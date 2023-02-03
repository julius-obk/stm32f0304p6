with stm32f0.Clock_Control;
with stm32f0.SysClock; use stm32f0.SysClock;
with M0;
with M0.Startup;       use M0.Startup;
with My_Rt;
with Real_Time.Delays;

procedure Stm32f0304p6 is
--Sysclk_Tick : New_Handler := My_Rt.Overflow_Callback;

--Bald : Time;
   package delays is new My_Rt.Delays;
begin
   stm32f0.Clock_Control.Setup_Sysclk;
   stm32f0.SysClock.Configure_Sysclk
     (Ticks_Per_Sec => 1_000, Sysfreq => stm32f0.Clock_Control.Get_Sys_Freq);

   --M0.Startup.Set_Handler (Systick_Interrupt_ID, Sysclk_Tick);

   while True loop
      delays.Delay_For (1.0);
      M0.Wait_For_Interrupt;
   end loop;

   --delay 1.0;

end Stm32f0304p6;
