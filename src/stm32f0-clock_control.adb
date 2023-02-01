with STM32F0x0.RCC; use STM32F0x0.RCC;

package body stm32f0.Clock_Control is

   rcc_reg : RCC_Peripheral renames RCC_Periph;

   ------------------
   -- Setup_Sysclk --
   ------------------

   procedure Setup_Sysclk is
   begin
      --enable HSE
      rcc_reg.CR.HSEBYP := False;   -- external crystal
      rcc_reg.CR.HSEON  := True;   -- hse on
      while not rcc_reg.CR.HSERDY loop   -- wait for rdy
         null;
      end loop;

--        To modify the PLL configuration, proceed as follows:
--  1.
--   Disable the PLL by setting PLLON to 0.
      rcc_reg.CR.PLLON := False;
--  2.
--   Wait until PLLRDY is cleared. The PLL is now fully stopped.
      while rcc_reg.CR.PLLRDY = True loop
         null;
      end loop;
--  3.
--   Change the desired parameter.
      rcc_reg.CFGR.PLLSRC  := 2#10#; --HSE Clk src
      rcc_reg.CFGR.PLLMUL  := 2#0100#; -- multi x6
      rcc_reg.CFGR2.PREDIV := 2#0000#; -- divided by 1
--  4.
--   Enable the PLL again by setting PLLON to 1.
      rcc_reg.CR.PLLON := True;

--  5.
--   Wait until PLLRDY is set.
      while rcc_reg.CR.PLLRDY = False loop
         null;
      end loop;
      --enable Clk Secure Sys
      rcc_reg.CR.CSSON := True;
      --set sysclk src to pll
      rcc_reg.CFGR.SWS := 2#10#;

      Sysclk_Freq := 48_000_000;
   end Setup_Sysclk;

   ------------------
   -- Get_Sys_Freq --
   ------------------

   function Get_Sys_Freq return Positive is
   begin
      return Sysclk_Freq;
   end Get_Sys_Freq;

end stm32f0.Clock_Control;
