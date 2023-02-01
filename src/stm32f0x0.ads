pragma Style_Checks (Off);

--  This spec has been automatically generated from STM32F0x0.svd

pragma Restrictions (No_Elaboration_Code);

with Interfaces;
with System;
with Ada.Unchecked_Conversion;

--  STM32F0x0
package STM32F0x0 is
   pragma Preelaborate;

   ---------------
   -- Base type --
   ---------------

   type UInt32 is new Interfaces.Unsigned_32;
   type UInt16 is new Interfaces.Unsigned_16;
   type Bool_Arr is array (Natural range 0 .. 31) of Boolean with
      Size => 32,
      Pack;
   function BoolArr2_U_Int32 is new Ada.Unchecked_Conversion
     (Source => Bool_Arr, Target => UInt32);
   function Uint32_2_BoolArr is new Ada.Unchecked_Conversion
     (Source => UInt32, Target => Bool_Arr);

   type Byte is new Interfaces.Unsigned_8;
   type Bit is mod 2**1 with
      Size => 1;
   type UInt2 is mod 2**2 with
      Size => 2;
   type UInt3 is mod 2**3 with
      Size => 3;
   type UInt4 is mod 2**4 with
      Size => 4;
   type UInt5 is mod 2**5 with
      Size => 5;
   type UInt6 is mod 2**6 with
      Size => 6;
   type UInt7 is mod 2**7 with
      Size => 7;
   type UInt9 is mod 2**9 with
      Size => 9;
   type UInt10 is mod 2**10 with
      Size => 10;
   type UInt11 is mod 2**11 with
      Size => 11;
   type UInt12 is mod 2**12 with
      Size => 12;
   type UInt13 is mod 2**13 with
      Size => 13;
   type UInt14 is mod 2**14 with
      Size => 14;
   type UInt15 is mod 2**15 with
      Size => 15;
   type UInt17 is mod 2**17 with
      Size => 17;
   type UInt18 is mod 2**18 with
      Size => 18;
   type UInt19 is mod 2**19 with
      Size => 19;
   type UInt20 is mod 2**20 with
      Size => 20;
   type UInt21 is mod 2**21 with
      Size => 21;
   type UInt22 is mod 2**22 with
      Size => 22;
   type UInt23 is mod 2**23 with
      Size => 23;
   type UInt24 is mod 2**24 with
      Size => 24;
   type UInt25 is mod 2**25 with
      Size => 25;
   type UInt26 is mod 2**26 with
      Size => 26;
   type UInt27 is mod 2**27 with
      Size => 27;
   type UInt28 is mod 2**28 with
      Size => 28;
   type UInt29 is mod 2**29 with
      Size => 29;
   type UInt30 is mod 2**30 with
      Size => 30;
   type UInt31 is mod 2**31 with
      Size => 31;

      --------------------
      -- Base addresses --
      --------------------

   CRC_Base    : constant System.Address := System'To_Address (16#4002_3000#);
   GPIOF_Base  : constant System.Address := System'To_Address (16#4800_1400#);
   GPIOD_Base  : constant System.Address := System'To_Address (16#4800_0C00#);
   GPIOC_Base  : constant System.Address := System'To_Address (16#4800_0800#);
   GPIOB_Base  : constant System.Address := System'To_Address (16#4800_0400#);
   GPIOA_Base  : constant System.Address := System'To_Address (16#4800_0000#);
   SPI1_Base   : constant System.Address := System'To_Address (16#4001_3000#);
   SPI2_Base   : constant System.Address := System'To_Address (16#4000_3800#);
   PWR_Base    : constant System.Address := System'To_Address (16#4000_7000#);
   I2C1_Base   : constant System.Address := System'To_Address (16#4000_5400#);
   I2C2_Base   : constant System.Address := System'To_Address (16#4000_5800#);
   IWDG_Base   : constant System.Address := System'To_Address (16#4000_3000#);
   WWDG_Base   : constant System.Address := System'To_Address (16#4000_2C00#);
   TIM1_Base   : constant System.Address := System'To_Address (16#4001_2C00#);
   TIM3_Base   : constant System.Address := System'To_Address (16#4000_0400#);
   TIM14_Base  : constant System.Address := System'To_Address (16#4000_2000#);
   TIM6_Base   : constant System.Address := System'To_Address (16#4000_1000#);
   TIM7_Base   : constant System.Address := System'To_Address (16#4000_1400#);
   EXTI_Base   : constant System.Address := System'To_Address (16#4001_0400#);
   NVIC_Base   : constant System.Address := System'To_Address (16#E000_E100#);
   DMA1_Base   : constant System.Address := System'To_Address (16#4002_0000#);
   RCC_Base    : constant System.Address := System'To_Address (16#4002_1000#);
   SYSCFG_Base : constant System.Address := System'To_Address (16#4001_0000#);
   ADC_Base    : constant System.Address := System'To_Address (16#4001_2400#);
   USART1_Base : constant System.Address := System'To_Address (16#4001_3800#);
   USART2_Base : constant System.Address := System'To_Address (16#4000_4400#);
   USART3_Base : constant System.Address := System'To_Address (16#4000_4800#);
   USART4_Base : constant System.Address := System'To_Address (16#4000_4C00#);
   USART6_Base : constant System.Address := System'To_Address (16#4001_1400#);
   USART5_Base : constant System.Address := System'To_Address (16#4000_5000#);
   RTC_Base    : constant System.Address := System'To_Address (16#4000_2800#);
   TIM15_Base  : constant System.Address := System'To_Address (16#4001_4000#);
   TIM16_Base  : constant System.Address := System'To_Address (16#4001_4400#);
   TIM17_Base  : constant System.Address := System'To_Address (16#4001_4800#);
   Flash_Base  : constant System.Address := System'To_Address (16#4002_2000#);
   DBGMCU_Base : constant System.Address := System'To_Address (16#4001_5800#);
   USB_Base    : constant System.Address := System'To_Address (16#4000_5C00#);
   SCB_Base    : constant System.Address := System'To_Address (16#E000_ED00#);
   STK_Base    : constant System.Address := System'To_Address (16#E000_E010#);

end STM32F0x0;
