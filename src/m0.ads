with STM32F0x0;     use STM32F0x0;
with STM32F0x0.SCB; use STM32F0x0.SCB;
with System;        use System;

with Interfaces; use Interfaces;

package M0 is
   type Exception_Num is new UInt6;
   function Get_ISR_Num return Exception_Num;
   procedure Block_All_Interrupts;
   procedure UnBlock_All_Interrupts;
   function All_Int_Blocked return Boolean;
   type Stack_Mode is (MSP, PSP) with
     Size => 1;
   for Stack_Mode use (MSP => 0, PSP => 1);
   function Get_Stack_Mode return Stack_Mode;
   procedure Set_Stack_Mode (This : Stack_Mode);

   type Exec_Mode is (Privileged, Unprivileged) with
     Size => 1;
   for Exec_Mode use (Privileged => 0, Unprivileged => 1);
   function Get_Exec_Mode return Exec_Mode;
   procedure Set_Exec_Mode (This : Exec_Mode);

   procedure Wait_For_Interrupt;
   procedure Wait_For_Event;

   subtype Handler_ID is ICSR_VECTACTIVE_Field;
   subtype Sys_Exception is Handler_ID range 0 .. 15;
   Reset_ID     : constant := 1;
   NMI_ID       : constant := 2;
   HardFault_ID : constant := 3;
   SVCall_ID    : constant := 11;
   PendSV_ID    : constant := 14;
   SysTick_ID   : constant := 15;

   subtype Interrupt_Exception is Handler_ID range 16 .. Handler_ID'Last;

   type Interrupt_ID is range 16 .. 47;
   function Handler_ID_2_Interupt_ID (This : Handler_ID) return Interrupt_ID;
   function Interrupt_ID_2_Handler_ID (This : Interrupt_ID) return Handler_ID;

   function Get_Current_Handler_ID return Handler_ID;

   type New_Handler is access procedure;

   procedure Set_Handler (Except : Handler_ID; This : New_Handler) with
     Pre => (Except <= Handler_ID (Interrupt_ID'Last));

   type Address_Array is array (Unsigned_8 range <>) of Address;
   type Access_Array is array (Unsigned_8 range <>) of New_Handler;

private
   use Standard.ASCII;
   LB : constant String := LF & HT;

   type IPSR is record
      ISR_Num  : Exception_Num;
      REserved : UInt26;
   end record with
     Size => 32;
   for IPSR use record
      ISR_Num  at 0 range 0 ..  5;
      REserved at 0 range 6 .. 31;
   end record;

   type Primask is record
      Is_Blocked : Boolean;
      Reserved   : UInt31;
   end record with
     Size => 32;
   for Primask use record
      Is_Blocked at 0 range 0 ..  0;
      Reserved   at 0 range 1 .. 31;
   end record;

   type Control is record
      Npriv    : Exec_Mode;
      Spsel    : Stack_Mode;
      Reserved : UInt30;
   end record with
     Size => 32;
   for Control use record
      Npriv    at 0 range 0 ..  0;
      Spsel    at 0 range 1 ..  1;
      Reserved at 0 range 2 .. 31;
   end record;

   Ram_Vector_Table : Access_Array := (1 .. 48 => null);

end M0;
