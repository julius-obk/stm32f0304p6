package stm32f0.Clock_Control is

   type Main_Clk_Out is
     (Pll_div2_out, HSI_out, HSI_ADC_out, HSE_out, SYSCLK_out, LSI_out,
      LSE_out);

   procedure Setup_Sysclk;
   function Get_Sys_Freq return Positive;

private
   Sysclk_Freq      : Positive := 8_000_000;
   HSE_Crystal_Freq : constant := 8_000_000;
end stm32f0.Clock_Control;
