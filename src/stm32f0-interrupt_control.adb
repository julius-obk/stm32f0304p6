pragma Ada_2012;

with STM32F0x0.NVIC; use STM32F0x0.NVIC;

package body stm32f0.Interrupt_Control is

   ------------
   -- Enable --
   ------------

   procedure Enable (This : Interrupt_Num) is
      IRQ_ID : Interrupt_ID := Interrupt_ID (This);
      Bools  : Bool_Arr     := Uint32_2_BoolArr (NVIC_Periph.ICER);
   begin
      Bools (This)     := True;
      NVIC_Periph.ICER := BoolArr2_U_Int32 (Bools);
   end Enable;

   -------------
   -- Disbale --
   -------------

   procedure Disbale (This : Interrupt_Num) is
      Bools : Bool_Arr := Uint32_2_BoolArr (NVIC_Periph.ICER);
   begin
      Bools (This)     := False;
      NVIC_Periph.ICER := BoolArr2_U_Int32 (Bools);
   end Disbale;

   ----------------
   -- Is_Enabled --
   ----------------

   function Is_Enabled (This : Interrupt_Num) return Boolean is
      Bools : Bool_Arr := Uint32_2_BoolArr (NVIC_Periph.ICER);
   begin
      return Bools (This);
   end Is_Enabled;

   ---------------------
   -- Raise_Interrupt --
   ---------------------

   procedure Raise_Interrupt (This : Interrupt_Num) is
      Bools : Bool_Arr := Uint32_2_BoolArr (NVIC_Periph.ISPR);
   begin
      Bools (This)     := True;
      NVIC_Periph.ISPR := BoolArr2_U_Int32 (Bools);
   end Raise_Interrupt;

   ---------------------
   -- Clear_Interrupt --
   ---------------------

   procedure Clear_Interrupt (This : Interrupt_Num) is
      Bools : Bool_Arr := Uint32_2_BoolArr (NVIC_Periph.ISPR);
   begin
      Bools (This)     := False;
      NVIC_Periph.ISPR := BoolArr2_U_Int32 (Bools);
   end Clear_Interrupt;

   --------------
   -- Set_Prio --
   --------------

   procedure Set_Prio (This : Interrupt_Num; Prio : Priority) is
      Result : constant access IPR0_Register :=
        (case This is when 0 .. 3 => NVIC_Periph.IPR0'Access,
           when 4 .. 7            => NVIC_Periph.IPR1'Access,
           when 8 .. 11           => NVIC_Periph.IPR2'Access,
           when 12 .. 15          => NVIC_Periph.IPR3'Access,
           when 16 .. 19          => NVIC_Periph.IPR4'Access,
           when 20 .. 23          => NVIC_Periph.IPR5'Access,
           when 24 .. 27          => NVIC_Periph.IPR6'Access,
           when 28 .. 31          => NVIC_Periph.IPR7'Access);

      Part : constant Interrupt_Num := This mod 4;
   begin

      case Part is
         when 0 =>
            Result.PRI_00 := Prio;
         when 1 =>
            Result.PRI_01 := Prio;
         when 2 =>
            Result.PRI_02 := Prio;
         when 3 =>
            Result.PRI_03 := Prio;
         when others =>
            raise Program_Error;
      end case;

   end Set_Prio;

--------------
-- Get_Prio --
--------------

   function Get_Prio (This : Interrupt_Num) return Priority is
      Result : constant access IPR0_Register :=
        (case This is when 0 .. 3 => NVIC_Periph.IPR0'Access,
           when 4 .. 7            => NVIC_Periph.IPR1'Access,
           when 8 .. 11           => NVIC_Periph.IPR2'Access,
           when 12 .. 15          => NVIC_Periph.IPR3'Access,
           when 16 .. 19          => NVIC_Periph.IPR4'Access,
           when 20 .. 23          => NVIC_Periph.IPR5'Access,
           when 24 .. 27          => NVIC_Periph.IPR6'Access,
           when 28 .. 31          => NVIC_Periph.IPR7'Access);

      Part : constant Interrupt_Num := This mod 4;
   begin

      case Part is
         when 0 =>
            return Result.PRI_00;
         when 1 =>
            return Result.PRI_01;
         when 2 =>
            return Result.PRI_02;
         when 3 =>
            return Result.PRI_03;
         when others =>
            raise Program_Error;
      end case;
   end Get_Prio;

end stm32f0.Interrupt_Control;
