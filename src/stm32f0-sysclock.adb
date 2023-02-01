with STM32F0x0;
with STM32F0x0.STK; use STM32F0x0.STK;
with M0.Startup;    use M0.Startup;

package body stm32f0.SysClock is
   Calibration_Reg        : CALIB_Register renames STK_Periph.CALIB;
   Calib_10ms_Val         : UInt24 renames Calibration_Reg.TENMS;
   Cali_10ms_Acurate      : Boolean renames Calibration_Reg.SKEW;
   Sysclk_Core_Clock_Only : Boolean renames Calibration_Reg.NOREF;

   Current_Value : UInt24 renames STK_Periph.CVR.CURRENT;
   Reload_Value  : UInt24 renames STK_Periph.RVR.RELOAD;

   Enable_Clk              : Boolean renames STK_Periph.CSR.ENABLE;
   ENable_Sysclk_Exception : Boolean renames STK_Periph.CSR.TICKINT;
   Core_Clk_As_Source      : Boolean renames STK_Periph.CSR.CLKSOURCE;
   Clk_Overflow            : Boolean renames STK_Periph.CSR.COUNTFLAG;

   procedure Get_Sub_S (Sub_S : out Sub_Sec_Reg) is
   begin
      Sub_S := Get_Current_Val;
   end Get_Sub_S;

   --------------------
   -- Disable_Sysclk --
   --------------------

   procedure Disable_Sysclk is
   begin
      Enable_Clk := False;
   end Disable_Sysclk;

   -------------------
   -- Enable_Sysclk --
   -------------------

   procedure Enable_Sysclk is
   begin
      Enable_Clk := True;
   end Enable_Sysclk;

   ------------------------
   -- Clear_Sysclk_Value --
   ------------------------

   procedure Clear_Sysclk_Value is
   begin
      Current_Value := 0;
   end Clear_Sysclk_Value;

   ----------------------
   -- Set_Reload_Value --
   ----------------------

   procedure Set_Reload_Value (This : Sub_Sec_Reg) is
   begin
      Reload_Value := This;
   end Set_Reload_Value;

   function Get_Reload_Value return Sub_Sec_Reg is (Reload_Value);

   -----------------------------
   -- Enable_Sysclk_Interrupt --
   -----------------------------

   procedure Enable_Sysclk_Interrupt (This : access procedure) is
   begin
      ENable_Sysclk_Exception := False;
      M0.Set_Handler (Except => Systick_Interrupt_ID, This => This);
      ENable_Sysclk_Exception := True;
   end Enable_Sysclk_Interrupt;

   ------------------------------
   -- Disable_Sysclk_Interrupt --
   ------------------------------

   procedure Disable_Sysclk_Interrupt is
   begin
      ENable_Sysclk_Exception := False;
   end Disable_Sysclk_Interrupt;

   ---------------------
   -- Get_Current_Val --
   ---------------------

   function Get_Current_Val return Sub_Sec_Reg is
   begin
      return Current_Value;
   end Get_Current_Val;

   ----------------------
   -- Configure_Sysclk --
   ----------------------

   procedure Configure_Sysclk (Ticks_Per_Sec : Positive; Sysfreq : Positive) is
      New_Reload_Val : UInt24;
   begin
      Disable_Sysclk;
      Sysclk_Freq    := Sysfreq;
      New_Reload_Val := UInt24 (Sysfreq / Ticks_Per_Sec);
      Set_Reload_Value (New_Reload_Val);
      Clear_Sysclk_Value;
      Enable_Sysclk;
   end Configure_Sysclk;

   procedure Clock (Sub_Sec : out Sub_Sec_Reg) is
   begin
      Sub_Sec := Get_Current_Val;
   end Clock;

end stm32f0.SysClock;
