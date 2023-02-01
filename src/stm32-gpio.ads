with STM32F103.GPIO; use STM32F103.GPIO;
with STM32F103;      use STM32F103;
with STM32; use Stm32;
with helpers;
with System;

generic
	My_Gpios : in out GPIO_Peripheral;
	First_Pin : in Natural := 0;
	Last_Pin : in Natural := 15;
package stm32.GPIO is
	type Pin is limited private;
	subtype Pin_Num is Integer range First_Pin .. Last_Pin;

	function New_Gpio_Pin (Num : Pin_Num) return Pin;

	type Mode is (Gpio_Out, Alt_Out, Gpio_In);
	function Get_Mode (Gpio_Pin : Pin) return Mode;
	procedure Set_Mode (Gpio_Pin : Pin; This : in Mode);

	type Out_Mode is (Push_Pull, Open_Drain);
	function Get_Out_Mode (Gpio_Pin : Pin) return Out_Mode with
	  Pre => Get_Mode (Gpio_Pin) /= Gpio_In;
	procedure Set_Out_Mode (Gpio_Pin : Pin; This : in Out_Mode);

	type In_Mode is (Analog, Floating, Pull_Down, Pull_Up);
	function Get_In_Mode (Gpio_Pin : Pin) return In_Mode with
	  Pre => Get_Mode (Gpio_Pin) = Gpio_In;
	procedure Set_In_Mode (Gpio_Pin : Pin; This : in In_Mode) with
	  Pre => Get_Mode (Gpio_Pin) = Gpio_In;

	type Out_Speed is (F_10mhz, F_2mhz, F_50mhz);

	function Get_Speed (Gpio_Pin : Pin) return Out_Speed with
	  Pre => Get_Mode (Gpio_Pin) /= Gpio_In;

	procedure Set_Speed (Gpio_Pin : in Pin; Speed : in Out_Speed);

	type State is (High, Low);

	function Clk_Enable return Boolean;
	function Clk_Disable return Boolean;

	procedure Set_Output (Gpio_Pin : in Pin; This : State) with
	  Pre => (Get_Mode (Gpio_Pin) /= Gpio_In and Clk_Enable);


	function Read_Input (Gpio_Pin : in Pin) return State with
	  Pre => (Get_Mode (Gpio_Pin) = Gpio_In and Clk_Enable);

	type pin_list is array (Pin_Num) of Pin_Num;




	--set_clear : BSRR_Register := (As_Array => True ) with
	  --import, Address => My_Gpios.BSRR'Address;
	atomic_set : BRR_BR_Field :=  (As_Array => True ) with
	import, Address => My_Gpios.BSRR.Br'Address;




private

	type Pin is limited record
		Number : Pin_Num;
	end record;

	function Read_Cnf (Gpio_Pin : Pin) return UInt2;
	procedure Write_Cnf (Gpio_Pin : Pin; This : UInt2);
	function Read_Mode (Gpio_Pin : Pin) return UInt2;
	procedure Write_Mode (Gpio_Pin : Pin; This : UInt2);
	function Read_Odr (Gpio_Pin : Pin) return Boolean;
	procedure Write_Odr (Gpio_Pin : Pin; This : Boolean);

	package Unit2_Tools is new helpers.bit_funcs (some_mod_type => UInt2);

	Gpio_Access : aliased GPIO_Peripheral := My_Gpios with
	  Volatile;




end stm32.GPIO;
