with stm32f0.SysClock;
with Real_Time;

package My_Rt is new Real_Time
  (Ticks_P_Sec => 1_000,
   Timer_Register_Sub_Seconds => stm32f0.SysClock.Sub_Sec_Reg,
   Count_Per_Tick => (48_000_000 / 1_000) - 1, -- sysfreq / ticks_per_sec -1
   Clock_Func => stm32f0.SysClock.Get_Sub_S);
