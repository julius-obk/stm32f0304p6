with STM32F0x0.GPIO; use STM32F0x0.GPIO;
with STM32F0x0;      use STM32F0x0;
with helpers;
with System;

generic
   My_Gpios : in out GPIO_Peripheral;
   First_Pin : in Natural := 0;
   Last_Pin : in Natural := 15;
package Stm32.GPIO is
   pragma Compile_Time_Error
     (Last_Pin < First_Pin and First_Pin < 16 and Last_Pin < 16,
      "Frist_Pin, Last_Pin must be smaller then 16" &
      "and First_Pin smaller then Last_Pin");
   pragma Assertion_Policy (Check);

   type Pin is limited private;
   subtype Pin_Num is Integer range First_Pin .. Last_Pin;

   function New_Gpio_Pin (Num : Pin_Num) return Pin;

   type Mode is (Input, Output, Alt_Funk, Analog);
   for Mode use
     (Input => 2#00#, Output => 2#01#, Alt_Funk => 2#10#, Analog => 2#11#);
   type Pull_Resistor is (None, Pull_Up, Pull_Down);
   for Pull_Resistor use (None => 2#00#, Pull_Up => 2#01#, Pull_Down => 2#10#);
   type Out_Mode is (Push_Pull, Open_Drain);
   for Out_Mode use (Push_Pull => 2#0#, Open_Drain => 2#1#);
   type Speed is (F_2mhz, F_10mhz, F_50mhz);
   for Speed use (F_2mhz => 2#00#, F_10mhz => 2#01#, F_50mhz => 2#10#);

   procedure Enable_Clock;
   function Clock_Enabled return Boolean;

   function Get_Mode (Gpio_Pin : Pin) return Mode;
   procedure Set_Mode
     (Gpio_Pin : Pin; This : Mode; Pull : Pull_Resistor := None;
      OM       : Out_Mode := Push_Pull);

   function Get_Input (Gpio_Pin : Pin) return Boolean with
     Pre => (Clock_Enabled and Get_Mode (Gpio_Pin) = Input);
   function Get_Output (Gpio_Pin : Pin) return Boolean with
     Pre => (Clock_Enabled and Get_Mode (Gpio_Pin) = Output);

   procedure Set_Output (Gpio_Pin : Pin; This : Boolean) with
     Pre => (Clock_Enabled and Get_Mode (Gpio_Pin) = Output);

   procedure Set_Speed (Gpio_Pin : Pin; This : Speed);

private

   type Pin is limited record
      Number : Pin_Num;
   end record;

   Gpios_Reg : aliased GPIO_Peripheral with
     Import, Address => My_Gpios'Address;
   Gpio_Access : constant access GPIO_Peripheral := Gpios_Reg'Access;
   GpioA_Acc   : constant access GPIO_Peripheral := GPIOA_Periph'Access;
   GpioB_Acc   : constant access GPIO_Peripheral := GPIOB_Periph'Access;
   GpioC_Acc   : constant access GPIO_Peripheral := GPIOC_Periph'Access;
   GpioD_Acc   : constant access GPIO_Peripheral := GPIOD_Periph'Access;
   GpioF_Acc   : constant access GPIO_Peripheral := GPIOF_Periph'Access;

end Stm32.GPIO;
