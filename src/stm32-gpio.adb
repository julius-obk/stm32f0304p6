with Ada.Unchecked_Conversion;
with STM32F0x0.RCC; use STM32F0x0.RCC;

package body Stm32.GPIO is

   function New_Gpio_Pin (Num : Pin_Num) return Pin is
   begin
      return This : Pin := (Number => Num);
   end New_Gpio_Pin;

   Mode_Reg  : MODER_Register renames My_Gpios.MODER;
   Otype_Reg : OTYPER_Register renames My_Gpios.OTYPER;
   Pull_Reg  : PUPDR_Register renames My_Gpios.PUPDR;
   Speed_Reg : OSPEEDR_Register renames My_Gpios.OSPEEDR;

   Enable_Reg : AHBENR_Register renames RCC_Periph.AHBENR;
   In_Reg     : IDR_Register renames My_Gpios.IDR;
   Out_Reg    : ODR_Register renames My_Gpios.ODR;

   procedure Set_Speed (Gpio_Pin : Pin; This : Speed) is
   begin
      Speed_Reg.Arr (Gpio_Pin.Number) := This'Enum_Rep;
   end Set_Speed;

   function To_Mode is new Ada.Unchecked_Conversion
     (Source => UInt2, Target => Mode);

   procedure Enable_Clock is
   begin
      if Gpio_Access = GpioA_Acc then
         Enable_Reg.IOPAEN := True;
      elsif Gpio_Access = GpioB_Acc then
         Enable_Reg.IOPBEN := True;
      elsif Gpio_Access = GpioC_Acc then
         Enable_Reg.IOPCEN := True;
      elsif Gpio_Access = GpioF_Acc then
         Enable_Reg.IOPFEN := True;
      end if;
   end Enable_Clock;

   function Clock_Enabled return Boolean is
      Result : Boolean := False;
   begin
      if Gpio_Access = GpioA_Acc then
         Result := Enable_Reg.IOPAEN;
      elsif Gpio_Access = GpioB_Acc then
         Result := Enable_Reg.IOPBEN;
      elsif Gpio_Access = GpioC_Acc then
         Result := Enable_Reg.IOPCEN;
      elsif Gpio_Access = GpioF_Acc then
         Result := Enable_Reg.IOPFEN;
      end if;
      return Result;
   end Clock_Enabled;

   function Get_Mode (Gpio_Pin : Pin) return Mode is
      Result : Mode;
   begin
      Result := To_Mode (Mode_Reg.Arr (Gpio_Pin.Number));
      return Result;
   end Get_Mode;

   procedure Set_Mode
     (Gpio_Pin : Pin; This : Mode; Pull : Pull_Resistor := None;
      OM       : Out_Mode := Push_Pull)
   is
   begin
      Enable_Clock;
      Mode_Reg.Arr (Gpio_Pin.Number)     := This'Enum_Rep;
      Pull_Reg.Arr (Gpio_Pin.Number)     := Pull'Enum_Rep;
      Otype_Reg.OT.Arr (Gpio_Pin.Number) :=
        (if OM'Enum_Rep = 0 then False else True);
   end Set_Mode;

   function Get_Input (Gpio_Pin : Pin) return Boolean is
   begin
      return In_Reg.IDR.Arr (Gpio_Pin.Number);
   end Get_Input;

   function Get_Output (Gpio_Pin : Pin) return Boolean is
     (Out_Reg.ODR.Arr (Gpio_Pin.Number));

   procedure Set_Output (Gpio_Pin : Pin; This : Boolean) is
   begin
      Out_Reg.ODR.Arr (Gpio_Pin.Number) := This;
   end Set_Output;

end Stm32.GPIO;
