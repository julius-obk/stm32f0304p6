--pragma Restrictions (No_Elaboration_Code);

with System;                  use System;
with System.Storage_Elements; use System.Storage_Elements;
with STM32F0x0.SCB;           use STM32F0x0.SCB;
with STM32F0x0;               use STM32F0x0;

package M0.Startup is
   --pragma Elaborate_Body;

   procedure Reset_Handler with
     Export, Convention => Ada, External_Name => "Reset_Handler";

   Reserved : constant Address := To_Address (16#00#);
   procedure NMI_Handler;
   procedure Hardfault_Handler;
   procedure MemManage_Handler;
   procedure Bus_Fault_Handler;
   procedure Usage_Fault_Handler;
   procedure SVCall_Handler;
   procedure Debug_Handler;
   procedure PendSV_Handler;
   procedure Systick_Handler;

   procedure Default_Handler with
     Export, Convention => Ada, External_Name => "Default_Handler";

   procedure Main with
     Import, Convention => Ada, External_Name => "main";

private

   Sram_Start : constant := 16#2000_0000#;
   --stack constant for calculation
   Sram_Stack_Length : constant := 16#1000#;
   -- init stack addr for vector table
   Sram_Stack_Start : constant Address :=
     System'To_Address (Sram_Start + Sram_Stack_Length);

   Vector_Table : constant Address_Array :=
     (Sram_Stack_Start, Reset_Handler'Address, NMI_Handler'Address,
      Hardfault_Handler'Address, MemManage_Handler'Address,
      Bus_Fault_Handler'Address, Usage_Fault_Handler'Address, Reserved,
      Reserved, Reserved, Reserved, SVCall_Handler'Address,
      Debug_Handler'Address, Reserved, PendSV_Handler'Address,
      Systick_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address, Default_Handler'Address,
      Default_Handler'Address);
   --Default_Handler'Address);
   pragma Linker_Section (Vector_Table, "_vector_table");

end M0.Startup;
