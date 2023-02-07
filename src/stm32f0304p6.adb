with stm32f0.Clock_Control;
with stm32f0.SysClock; use stm32f0.SysClock;
with M0;               use M0;
with M0.Startup;       use M0.Startup;
with My_Rt;            use My_Rt;
with Real_Time.Delays;
with Stm32.GPIO;
with STM32F0x0.GPIO;

procedure Stm32f0304p6 is
   Sysclk_Tick : New_Handler := My_Rt.Overflow_Callback;

   Bald : Time_Span := To_Time_Span (60.0 * 60.0);
   package Delays is new My_Rt.Delays;
   package My_Gpio is new Stm32.GPIO
     (My_Gpios => STM32F0x0.GPIO.GPIOA_Periph, First_Pin => 0, Last_Pin => 13);
   use My_Gpio;
   led : Pin := New_Gpio_Pin (4);

begin
   stm32f0.Clock_Control.Setup_Sysclk;
   stm32f0.SysClock.Configure_Sysclk
     (Ticks_Per_Sec => 1_000, Sysfreq => stm32f0.Clock_Control.Get_Sys_Freq);

   stm32f0.SysClock.Enable_Sysclk_Interrupt (Sysclk_Tick);
   Set_Mode (led, Output);

   while True loop
      Delays.Delay_For (1.0);
      Set_Output (led, not Get_Output (led));
      M0.Wait_For_Interrupt;
   end loop;

   --delay 1.0;

end Stm32f0304p6;
