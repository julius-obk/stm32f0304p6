pragma Style_Checks (Off);

--  This spec has been automatically generated from STM32F0x0.svd

--  Definition of the device's interrupts
package STM32F0x0.Interrupts is

   ----------------
   -- Interrupts --
   ----------------

   --  Window Watchdog interrupt
   WWDG_Interrupt                 : constant := 0;

   --  PVD and VDDIO2 supply comparator interrupt
   PVD_Interrupt                  : constant := 1;

   --  RTC interrupts
   RTC_Interrupt                  : constant := 2;

   --  Flash global interrupt
   FLASH_Interrupt                : constant := 3;

   --  RCC global interruptr
   RCC_Interrupt                  : constant := 4;

   --  EXTI Line[1:0] interrupts
   EXTI0_1_Interrupt              : constant := 5;

   --  EXTI Line[3:2] interrupts
   EXTI2_3_Interrupt              : constant := 6;

   --  EXTI Line15 and EXTI4 interrupts
   EXTI4_15_Interrupt             : constant := 7;

   --  DMA1 channel 1 interrupt
   DMA1_CH1_Interrupt             : constant := 9;

   --  DMA1 channel 2 and 3 interrupt
   DMA1_CH2_3_Interrupt           : constant := 10;

   --  DMA1 channel 4 and 5 interrupt
   DMA1_CH4_5_Interrupt           : constant := 11;

   --  ADC interrupt
   ADC_Interrupt                  : constant := 12;

   --  TIM1 break, update, trigger and commutation interrupt
   TIM1_BRK_UP_TRG_COM_Interrupt  : constant := 13;

   --  TIM1 Capture Compare interrupt
   TIM1_CC_Interrupt              : constant := 14;

   --  TIM3 global interrupt
   TIM3_Interrupt                 : constant := 16;

   --  TIM6 global interrupt
   TIM6_Interrupt                 : constant := 17;

   --  TIM14 global interrupt
   TIM14_Interrupt                : constant := 19;

   --  TIM15 global interrupt
   TIM15_Interrupt                : constant := 20;

   --  TIM16 global interrupt
   TIM16_Interrupt                : constant := 21;

   --  TIM17 global interrupt
   TIM17_Interrupt                : constant := 22;

   --  I2C1 global interrupt
   I2C1_Interrupt                 : constant := 23;

   --  I2C2 global interrupt
   I2C2_Interrupt                 : constant := 24;

   --  SPI1_global_interrupt
   SPI1_Interrupt                 : constant := 25;

   --  SPI2 global interrupt
   SPI2_Interrupt                 : constant := 26;

   --  USART1 global interrupt
   USART1_Interrupt               : constant := 27;

   --  USART2 global interrupt
   USART2_Interrupt               : constant := 28;

   --  USART3, USART4, USART5, USART6 global interrupt
   USART3_4_5_6_Interrupt         : constant := 29;

   --  USB global interrupt
   USB_Interrupt                  : constant := 31;

end STM32F0x0.Interrupts;
