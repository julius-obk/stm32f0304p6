with Startup;   use Startup;
with STM32F0x0; use STM32F0x0;

package stm32f0.Interrupt_Control is
   subtype Interrupt_Num is Integer range 0 .. 31;

   procedure Enable (This : Interrupt_Num);
   procedure Disbale (This : Interrupt_Num);
   function Is_Enabled (This : Interrupt_Num) return Boolean;
   procedure Raise_Interrupt (This : Interrupt_Num);
   procedure Clear_Interrupt (This : Interrupt_Num);

   subtype Priority is STM32F0x0.UInt2;
   procedure Set_Prio (This : Interrupt_Num; Prio : Priority);
   function Get_Prio (This : Interrupt_Num) return Priority;

end stm32f0.Interrupt_Control;
