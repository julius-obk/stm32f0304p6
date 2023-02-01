with Ada.Unchecked_Conversion;
with STM32F103.RCC;  use STM32F103.RCC;
with STM32F103.GPIO; use STM32F103.GPIO;

package body stm32.GPIO is

   function New_Gpio_Pin (Num : Pin_Num) return Pin is
   begin
      return This : Pin := (Number => Num);
   end New_Gpio_Pin;

   function Read_Cnf (Gpio_Pin : Pin) return UInt2 is
   begin
      case Gpio_Pin.Number is
         when 0 =>
            return My_Gpios.CRL.CNF0;
         when 1 =>
            return My_Gpios.CRL.CNF1;
         when 2 =>
            return My_Gpios.CRL.CNF2;
         when 3 =>
            return My_Gpios.CRL.CNF3;
         when 4 =>
            return My_Gpios.CRL.CNF4;
         when 5 =>
            return My_Gpios.CRL.CNF5;
         when 6 =>
            return My_Gpios.CRL.CNF6;
         when 7 =>
            return My_Gpios.CRL.CNF7;
         when 8 =>
            return My_Gpios.CRH.CNF8;
         when 9 =>
            return My_Gpios.CRH.CNF9;
         when 10 =>
            return My_Gpios.CRH.CNF10;
         when 11 =>
            return My_Gpios.CRH.CNF11;
         when 12 =>
            return My_Gpios.CRH.CNF12;
         when 13 =>
            return My_Gpios.CRH.CNF13;
         when 14 =>
            return My_Gpios.CRH.CNF14;
         when 15 =>
            return My_Gpios.CRH.CNF15;
         when others =>
            raise Constraint_Error;
      end case;
   end Read_Cnf;

   procedure Write_Cnf (Gpio_Pin : Pin; This : UInt2) is
   begin
      case Gpio_Pin.Number is
         when 0 =>
            My_Gpios.CRL.CNF0 := This;
         when 1 =>
            My_Gpios.CRL.CNF1 := This;
         when 2 =>
            My_Gpios.CRL.CNF2 := This;
         when 3 =>
            My_Gpios.CRL.CNF3 := This;
         when 4 =>
            My_Gpios.CRL.CNF4 := This;
         when 5 =>
            My_Gpios.CRL.CNF5 := This;
         when 6 =>
            My_Gpios.CRL.CNF6 := This;
         when 7 =>
            My_Gpios.CRL.CNF7 := This;
         when 8 =>
            My_Gpios.CRH.CNF8 := This;
         when 9 =>
            My_Gpios.CRH.CNF9 := This;
         when 10 =>
            My_Gpios.CRH.CNF10 := This;
         when 11 =>
            My_Gpios.CRH.CNF11 := This;
         when 12 =>
            My_Gpios.CRH.CNF12 := This;
         when 13 =>
            My_Gpios.CRH.CNF13 := This;
         when 14 =>
            My_Gpios.CRH.CNF14 := This;
         when 15 =>
            My_Gpios.CRH.CNF15 := This;
         when others =>
            raise Constraint_Error;
      end case;
   end Write_Cnf;

   function Read_Mode (Gpio_Pin : Pin) return UInt2 is
   begin
      case Gpio_Pin.Number is
         when 0 =>
            return My_Gpios.CRL.MODE0;
         when 1 =>
            return My_Gpios.CRL.MODE1;
         when 2 =>
            return My_Gpios.CRL.MODE2;
         when 3 =>
            return My_Gpios.CRL.MODE3;
         when 4 =>
            return My_Gpios.CRL.MODE4;
         when 5 =>
            return My_Gpios.CRL.MODE5;
         when 6 =>
            return My_Gpios.CRL.MODE6;
         when 7 =>
            return My_Gpios.CRL.MODE7;
         when 8 =>
            return My_Gpios.CRH.MODE8;
         when 9 =>
            return My_Gpios.CRH.MODE9;
         when 10 =>
            return My_Gpios.CRH.MODE10;
         when 11 =>
            return My_Gpios.CRH.MODE11;
         when 12 =>
            return My_Gpios.CRH.MODE12;
         when 13 =>
            return My_Gpios.CRH.MODE13;
         when 14 =>
            return My_Gpios.CRH.MODE14;
         when 15 =>
            return My_Gpios.CRH.MODE15;
         when others =>
            raise Constraint_Error;
      end case;
   end Read_Mode;

   procedure Write_Mode (Gpio_Pin : Pin; This : UInt2) is
   begin
      case Gpio_Pin.Number is
         when 0 =>
            My_Gpios.CRL.MODE0 := This;
         when 1 =>
            My_Gpios.CRL.MODE1 := This;
         when 2 =>
            My_Gpios.CRL.MODE2 := This;
         when 3 =>
            My_Gpios.CRL.MODE3 := This;
         when 4 =>
            My_Gpios.CRL.MODE4 := This;
         when 5 =>
            My_Gpios.CRL.MODE5 := This;
         when 6 =>
            My_Gpios.CRL.MODE6 := This;
         when 7 =>
            My_Gpios.CRL.MODE7 := This;
         when 8 =>
            My_Gpios.CRH.MODE8 := This;
         when 9 =>
            My_Gpios.CRH.MODE9 := This;
         when 10 =>
            My_Gpios.CRH.MODE10 := This;
         when 11 =>
            My_Gpios.CRH.MODE11 := This;
         when 12 =>
            My_Gpios.CRH.MODE12 := This;
         when 13 =>
            My_Gpios.CRH.MODE13 := This;
         when 14 =>
            My_Gpios.CRH.MODE14 := This;
         when 15 =>
            My_Gpios.CRH.MODE15 := This;
         when others =>
            raise Constraint_Error;
      end case;
   end Write_Mode;

   type Bool_Arr_16 is array (Integer range 1 .. 16) of Boolean;
   pragma Pack (Bool_Arr_16);

   function Uint16_To_BoolArr16 is new Ada.Unchecked_Conversion
     (Source => UInt16, Target => Bool_Arr_16);
   function BoolArr16_To_Uint16 is new Ada.Unchecked_Conversion
     (Source => Bool_Arr_16, Target => UInt16);

   function Read_Odr (Gpio_Pin : Pin) return Boolean is
      Temp   : UInt16 := My_Gpios.ODR.ODR.Val;
      Result : Bool_Arr_16;
   begin
      Result := Uint16_To_BoolArr16 (Temp);
      return Result (Gpio_Pin.Number);
   end Read_Odr;

   procedure Write_Odr (Gpio_Pin : Pin; This : Boolean) is
      Temp : Bool_Arr_16 := (others => False);
   begin
      Temp (Gpio_Pin.Number) := True;
      My_Gpios.ODR.ODR.Val   := BoolArr16_To_Uint16 (Temp);

   end Write_Odr;

   function Get_Mode (Gpio_Pin : Pin) return Mode is
      Mode : UInt2 := Read_Mode (Gpio_Pin);
      Cnf  : UInt2 := Read_Cnf (Gpio_Pin);
   begin
      if Mode = 0 then
         return Gpio_In;
      elsif Cnf > 1 then
         return Alt_Out;
      else
         return Gpio_Out;
      end if;

   end Get_Mode;

   procedure Set_Mode (Gpio_Pin : Pin; This : in Mode) is
      use Unit2_Tools;
      Cnf : UInt2 := Read_Cnf (Gpio_Pin);
   begin
      case This is
         when Gpio_In =>
            Write_Mode (Gpio_Pin, 0);
         when Alt_Out =>
            Set (This => Cnf, bit => 2);
            Write_Cnf (Gpio_Pin, Cnf);
         when Gpio_Out =>
            Clear (This => Cnf, bit => 2);
            Write_Cnf (Gpio_Pin => Gpio_Pin, This => Cnf);
      end case;
   end Set_Mode;

   function Get_Out_Mode (Gpio_Pin : Pin) return Out_Mode is
      Cnf : UInt2 := Read_Cnf (Gpio_Pin);
   begin
      if Cnf = 2#01# or Cnf = 2#11# then
         return Push_Pull;
      else
         return Open_Drain;
      end if;
   end Get_Out_Mode;

   procedure Set_Out_Mode (Gpio_Pin : Pin; This : in Out_Mode) is
      use Unit2_Tools;
      Cnf : UInt2 := Read_Cnf (Gpio_Pin);
   begin
      case This is
         when Push_Pull =>
            Set (This => Cnf, bit => 1);
            Write_Cnf (Gpio_Pin => Gpio_Pin, This => Cnf);
         when Open_Drain =>
            Clear (This => Cnf, bit => 1);
            Write_Cnf (Gpio_Pin => Gpio_Pin, This => Cnf);
      end case;
   end Set_Out_Mode;

   function Get_In_Mode (Gpio_Pin : Pin) return In_Mode is
      Cnf : UInt2   := Read_Cnf (Gpio_Pin);
      Odr : Boolean := Read_Odr (Gpio_Pin);
   begin
      case Cnf is
         when 2#00# =>
            return Analog;
         when 2#01# =>
            return Floating;
         when others =>
            if not Odr then
               return Pull_Down;
            else
               return Pull_Up;
            end if;
      end case;
   end Get_In_Mode;

   procedure Set_In_Mode (Gpio_Pin : Pin; This : in In_Mode) is
      Cnf : UInt2   := Read_Cnf (Gpio_Pin);
      Odr : Boolean := Read_Odr (Gpio_Pin);
   begin
      case This is
         when Analog =>
            Write_Cnf (Gpio_Pin, 2#00#);
         when Floating =>
            Write_Cnf (Gpio_Pin, 2#01#);
         when Pull_Down =>
            Write_Cnf (Gpio_Pin, 2#10#);
         when Pull_Up =>
            Write_Cnf (Gpio_Pin, 2#00#);
            Write_Odr (Gpio_Pin, True);
      end case;
   end Set_In_Mode;

   function Get_Speed (Gpio_Pin : Pin) return Out_Speed is
      subtype Speeds is UInt2 range 1 .. 3;
      Mode : Speeds := Read_Mode (Gpio_Pin);
   begin
      case Mode is
         when 2#01# =>
            return F_10mhz;
         when 2#10# =>
            return F_2mhz;
         when 2#11# =>
            return F_50mhz;
      end case;
   end Get_Speed;

   procedure Set_Speed (Gpio_Pin : in Pin; Speed : in Out_Speed) is
   begin
      case Speed is
         when F_10mhz =>
            Write_Mode (Gpio_Pin, 2#01#);
         when F_2mhz =>
            Write_Mode (Gpio_Pin, 2#10#);
         when F_50mhz =>
            Write_Mode (Gpio_Pin, 2#11#);
      end case;
   end Set_Speed;

   procedure Set_Output (Gpio_Pin : in Pin; This : State) is
      Boolarr : Bool_Arr_16 := (others => False);
   begin
      Boolarr (Gpio_Pin.Number) := True;
      case This is
         when High =>
            My_Gpios.BSRR.BS.Val := BoolArr16_To_Uint16 (Boolarr);
         when Low =>
            My_Gpios.BRR.BR.Val := BoolArr16_To_Uint16 (Boolarr);
      end case;
   end Set_Output;

   function Read_Input (Gpio_Pin : in Pin) return State is
      Boolarr : Bool_Arr_16 := Uint16_To_BoolArr16 (My_Gpios.IDR.IDR.Val);
   begin
      if Boolarr (Gpio_Pin.Number) then
         return High;
      else
         return Low;
      end if;
   end Read_Input;

   function Clk_Enable return Boolean is
      Enable_Bits : APB2ENR_Register renames STM32F103.RCC.RCC_Periph.APB2ENR;
      Test_Access : access GPIO_Peripheral := Gpio_Access'Access;
      Result      : Boolean;
   begin
      if Test_Access = GPIOA_Periph'Access then
         Enable_Bits.IOPAEN := True;
         Result             := Enable_Bits.IOPAEN;
      elsif Test_Access = GPIOB_Periph'Access then
         Enable_Bits.IOPBEN := True;
         Result             := Enable_Bits.IOPBEN;
      elsif Test_Access = GPIOC_Periph'Access then
         Enable_Bits.IOPCEN := True;
         Result             := Enable_Bits.IOPCEN;
      elsif Test_Access = GPIOD_Periph'Access then
         Enable_Bits.IOPDEN := True;
         Result             := Enable_Bits.IOPDEN;
      elsif Test_Access = GPIOE_Periph'Access then
         Enable_Bits.IOPEEN := True;
         Result             := Enable_Bits.IOPEEN;
      elsif Test_Access = GPIOF_Periph'Access then
         Enable_Bits.IOPFEN := True;
         Result             := Enable_Bits.IOPFEN;
      elsif Test_Access = GPIOG_Periph'Access then
         Enable_Bits.IOPGEN := True;
         Result             := Enable_Bits.IOPGEN;
      end if;
      return Result;
   end Clk_Enable;

   function Clk_Disable return Boolean is

      Enable_Bits : APB2ENR_Register renames STM32F103.RCC.RCC_Periph.APB2ENR;
      Test_Access : access GPIO_Peripheral := Gpio_Access'Access;
      Result      : Boolean;
   begin
      if Test_Access = GPIOA_Periph'Access then
         Enable_Bits.IOPAEN := False;
         Result             := Enable_Bits.IOPAEN;
      elsif Test_Access = GPIOB_Periph'Access then
         Enable_Bits.IOPBEN := False;
         Result             := Enable_Bits.IOPBEN;
      elsif Test_Access = GPIOC_Periph'Access then
         Enable_Bits.IOPCEN := False;
         Result             := Enable_Bits.IOPCEN;
      elsif Test_Access = GPIOD_Periph'Access then
         Enable_Bits.IOPDEN := False;
         Result             := Enable_Bits.IOPDEN;
      elsif Test_Access = GPIOE_Periph'Access then
         Enable_Bits.IOPEEN := False;
         Result             := Enable_Bits.IOPEEN;
      elsif Test_Access = GPIOF_Periph'Access then
         Enable_Bits.IOPFEN := False;
         Result             := Enable_Bits.IOPFEN;
      elsif Test_Access = GPIOG_Periph'Access then
         Enable_Bits.IOPGEN := False;
         Result             := Enable_Bits.IOPGEN;
      end if;
      return Result;
   end Clk_Disable;





end stm32.GPIO;
