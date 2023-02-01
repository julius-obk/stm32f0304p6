with STM32F0x0.STK; use STM32F0x0.STK;
with STM32F0x0;     use STM32F0x0;

package stm32f0.SysClock is
   subtype Sub_Sec_Reg is STM32F0x0.UInt24;

   procedure Disable_Sysclk;
   procedure Enable_Sysclk;
   procedure Clear_Sysclk_Value;
   procedure Set_Reload_Value (This : Sub_Sec_Reg);
   function Get_Reload_Value return Sub_Sec_Reg;

   procedure Enable_Sysclk_Interrupt (This : access procedure);
   procedure Disable_Sysclk_Interrupt;

   function Get_Current_Val return Sub_Sec_Reg;
   procedure Get_Sub_S (Sub_s : out Sub_Sec_Reg);
   procedure Clock (Sub_Sec : out Sub_Sec_Reg);

   procedure Configure_Sysclk
     (Ticks_Per_Sec : Positive; Sysfreq : Positive) with
     Pre =>
      (Sysfreq / Ticks_Per_Sec) >= 100 and (Sysfreq mod Ticks_Per_Sec) = 0;

   Systick_Interrupt_ID : constant := 15;

private
   Sysclk_Freq : Positive;

end stm32f0.SysClock;
