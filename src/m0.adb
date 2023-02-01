with System.Machine_Code; use System.Machine_Code;
--with Standard.ASCII;

with Ada.Unchecked_Conversion;
with System.Storage_Elements; use System.Storage_Elements;
with Interfaces;              use Interfaces;

package body M0 is
   function SE2IPSR is new Ada.Unchecked_Conversion
     (Source => Storage_Element, Target => IPSR);

   function IPSR2SE is new Ada.Unchecked_Conversion
     (Source => IPSR, Target => Storage_Element);

   -----------------
   -- Get_ISR_Num --
   -----------------

   function Get_ISR_Num return Exception_Num is
      Temp2 : IPSR := (0, 0);
   begin
      Asm
        (Template => "mrs r0, IPSR" &
           LB & -- move special register to reg 0

           "str r0, %0", -- move reg 0 into variable
         Outputs  => IPSR'Asm_Output ("=m", Temp2), Clobber => "r0",
         Volatile => True);
      return Temp2.ISR_Num;
   end Get_ISR_Num;

   function All_Int_Blocked return Boolean is
      Temp : Primask;
   begin
      Asm
        (Template => "Mrs r0, PRIMASK" &
           LB & -- move special register to reg 0

           "str r0, %0", -- move reg 0 into variable
         Outputs  => Primask'Asm_Output ("=m", Temp), Clobber => "r0",
         Volatile => True);
      return Temp.Is_Blocked;
   end All_Int_Blocked;
   --------------------------
   -- Block_All_Interrupts --
   --------------------------

   procedure Block_All_Interrupts is
      Temp : constant Primask := (True, 16#0#);
   begin
      Asm
        (Template => "ldr r0, %0" &
           LB & -- load input var to reg 0

           "MSR PRIMASK, r0", -- move reg 0 into reg primask
         Inputs   => Primask'Asm_Input ("m", Temp), Clobber => "r0",
         Volatile => True);
   end Block_All_Interrupts;

   ----------------------------
   -- UnBlock_All_Interrupts --
   ----------------------------

   procedure UnBlock_All_Interrupts is
      Temp : constant Primask := (False, 16#0#);
   begin
      Asm
        (Template => "ldr r0, %0" &
           LB & -- load variable into reg0

           "MSR PRIMASK, r0", -- move reg 0 into Primask
         Inputs   => Primask'Asm_Input ("m", Temp), Clobber => "r0",
         Volatile => True);
   end UnBlock_All_Interrupts;

   --------------------
   -- Get_Stack_Mode --
   --------------------
   function Get_Control return Control is
      Temp2 : Control;
   begin
      Asm
        (Template => "mrs r0, CONTROL" &
           LB & -- move special register to reg 0

           "str r0, %0", -- move reg 0 into variable
         Outputs  => Control'Asm_Output ("=m", Temp2), Clobber => "r0",
         Volatile => True);
      return Temp2;
   end Get_Control;

   procedure Set_Control (This : out Control) is
   begin
      Asm
        (Template => "ldr r0, %0" &
           LB & -- load variable into reg 0

           "MSR CONTROL, r0", -- move reg 0 into control
         Inputs   => Control'Asm_Input ("m", This), Clobber => "r0",
         Volatile => True);
   end Set_Control;

   function Get_Stack_Mode return Stack_Mode is
      Result : constant Control := Get_Control;
   begin
      return Result.Spsel;
   end Get_Stack_Mode;

   --------------------
   -- Set_Stack_Mode --
   --------------------

   procedure Set_Stack_Mode (This : Stack_Mode) is
      Temp : Control;
   begin
      Temp       := Get_Control;
      Temp.Spsel := This;
      Set_Control (Temp);
   end Set_Stack_Mode;

   -------------------
   -- Get_Exec_Mode --
   -------------------

   function Get_Exec_Mode return Exec_Mode is
      Temp : Control := Get_Control;
   begin
      return Temp.Npriv;
   end Get_Exec_Mode;

   -------------------
   -- Set_Exec_Mode --
   -------------------

   procedure Set_Exec_Mode (This : Exec_Mode) is
      Temp : Control := Get_Control;
   begin
      Temp.Npriv := This;
      Set_Control (Temp);
   end Set_Exec_Mode;

   ------------------------
   -- Wait_For_Interrupt --
   ------------------------

   procedure Wait_For_Interrupt is
   begin
      Asm (Template => "WFI");
   end Wait_For_Interrupt;

   --------------------
   -- Wait_For_Event --
   --------------------

   procedure Wait_For_Event is
   begin
      Asm (Template => "WFE");
   end Wait_For_Event;

   function Handler_ID_2_Interupt_ID (This : Handler_ID) return Interrupt_ID is
     (Interrupt_ID (This));

   function Interrupt_ID_2_Handler_ID
     (This : Interrupt_ID) return Handler_ID is
     (Handler_ID (This));

   function Get_Current_Handler_ID return Handler_ID is
      Result : Handler_ID;
   begin
      Result := SCB_Periph.ICSR.VECTACTIVE;
      return Result;
   end Get_Current_Handler_ID;

   procedure Set_Handler (Except : Handler_ID; This : New_Handler) is
   begin
      Ram_Vector_Table (Unsigned_8 (Except)) := This;
   end Set_Handler;

end M0;
