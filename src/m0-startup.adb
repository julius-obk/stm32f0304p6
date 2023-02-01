with GNAT.IO;             use GNAT.IO;
with System.Machine_Code; use System.Machine_Code;
with Interfaces;          use Interfaces;
with STM32F0x0;           use STM32F0x0;
with STM32F0x0.SCB;       use STM32F0x0.SCB;
with Ada.Assertions;
with stm32f0.SysClock;
with System.Address_To_Access_Conversions;
with Ada.Unchecked_Conversion;

package body M0.Startup is

   function Addr2SO is new Ada.Unchecked_Conversion
     (Source => System.Address, Target => Storage_Offset);

   procedure Set_Stack_Pointer (There : Address) is
   begin
      --backup content of r0
      --Asm("str %0, r0",
      --Outputs => (Unsigned_32'Asm_Output ("=m", backup_r0)));
      -- set stack pointer
      Asm
        ("ldr r0, %0" & LB & "mov sp, r0",
         Inputs => (Address'Asm_Input ("m", There)), Clobber => "r0");
   end Set_Stack_Pointer;

   -------------------
   -- Reset_Handler --
   -------------------

   procedure Reset_Handler is

      Data_Start : Storage_Element with
        Volatile, Import, External_Name => "__data_start";

      Data_Stop : Storage_Element with
        Volatile, Import, External_Name => "__data_end";

      Data_Flash_Load : Storage_Element with
        Volatile, Import, External_Name => "__data_load";

      Data_L : Storage_Element with
        Volatile, Import, External_Name => "__data_size";

      Data_Length : constant Storage_Offset := Addr2SO (Data_L'Address);

      Data_Load_Array : Storage_Array (1 .. Data_Length) with
        Volatile, Import, Address => Data_Flash_Load'Address;

      Data_Ram_Array : Storage_Array (1 .. Data_Length) with
        Volatile, Import, Address => Data_Start'Address;

      --------------------
      -- bss

      Bss_Start : Storage_Element with
        Volatile, Import, Convention => Asm, External_Name => "__bss_start";

      Bss_End : Storage_Element with
        Volatile, Import, Convention => Asm, External_Name => "__bss_end";

      Bss_L : Storage_Element with
        Volatile, Import, Convention => Asm, External_Name => "__bss_size";

      Bss_Length : constant Storage_Offset := Addr2SO (Bss_L'Address);

      Bss_Array : Storage_Array (1 .. Bss_Length) with
        Volatile, Import, Address => Bss_Start'Address;

      Stack_Start : Storage_Offset with
        Volatile, Import, Convention => Asm, External_Name => "__stack_end";
      -- stack start is stack end, because stack grows downward

      Stack_Size : Storage_Offset with
        Volatile, Import, Convention => Asm, External_Name => "__stack_size";

   begin
      --set stack pointer
      Set_Stack_Pointer (Stack_Start'Address);

      --copy data section to ram
      for Data_Count in Data_Load_Array'Range loop
         Data_Ram_Array (Data_Count) := Data_Load_Array (Data_Count);
      end loop;
      -- clear bss
      Bss_Array := (others => 16#00#);
      --call main
      Main;
   end Reset_Handler;

   ---------------------
   -- Default_Handler --
   ---------------------

   procedure Default_Handler is
      Current_Handler : Exception_Num :=
        Exception_Num (Get_Current_Handler_ID);
      Current_ISR_Num    : Exception_Num := Get_ISR_Num;
      Vector_Table_Index : Unsigned_8    := Unsigned_8 (Current_Handler);
   begin
      Ada.Assertions.Assert (Current_Handler = Current_ISR_Num);
      if Ram_Vector_Table (Vector_Table_Index)'Address /=
        Default_Handler'Address
        and then Ram_Vector_Table (Vector_Table_Index) /= null
      then
         Ram_Vector_Table (Vector_Table_Index).all;
      else
         null;
      end if;

   end Default_Handler;

   procedure NMI_Handler is
      Msg : String := "NMI Fault";
   begin
      Put_Line (Msg);
      Default_Handler;
   end NMI_Handler;

   procedure Hardfault_Handler is
      Msg : String := "Hard Fault";
   begin
      Put_Line (Msg);
      Default_Handler;
   end Hardfault_Handler;

   procedure MemManage_Handler is
      Msg : String := "MemManage Fault";
   begin
      Put_Line (Msg);
      Default_Handler;
   end MemManage_Handler;

   procedure Bus_Fault_Handler is
      Msg : String := "Bus Fault";
   begin
      Put_Line (Msg);
      Default_Handler;
   end Bus_Fault_Handler;

   procedure Usage_Fault_Handler is
      Msg : String := "Useage Fault";
   begin
      Put_Line (Msg);
      Default_Handler;
   end Usage_Fault_Handler;

   procedure SVCall_Handler is
      Msg : String := "SVcall";
   begin
      Put_Line (Msg);
      Default_Handler;
   end SVCall_Handler;

   procedure PendSV_Handler is
      Msg : String := "PendSV";
   begin
      Put_Line (Msg);
      Default_Handler;
   end PendSV_Handler;

   procedure Systick_Handler is
      Msg : String := "Systick";
   begin
      Put_Line (Msg);
      Default_Handler;
   end Systick_Handler;

   procedure Debug_Handler is
      Msg : String := "Debug";
   begin
      Put_Line (Msg);
   end Debug_Handler;

end M0.Startup;
