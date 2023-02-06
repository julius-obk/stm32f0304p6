pragma Ada_2012;
with Ada.Unchecked_Conversion;

package body helpers is

   ---------------
   -- bit_funcs --
   ---------------

   package body bit_funcs is
      function Uint_To_BoolArr is new Ada.Unchecked_Conversion
        (Source => some_mod_type, Target => bit_array);

      function BoolArr_To_Uint is new Ada.Unchecked_Conversion
        (Source => bit_array, Target => some_mod_type);
      ---------
      -- Set --
      ---------

      procedure Set (This : in out some_mod_type; bit : bit_number) is
         bitarr : bit_array := (others => False);
      begin
         bitarr (bit) := True;
         bitarr       := bitarr or Uint_To_BoolArr (This);
         This         := BoolArr_To_Uint (bitarr);

      end Set;

      ---------
      -- Set --
      ---------

      procedure Set (This : in out some_mod_type; bits : bit_array) is
      begin
         This := This or BoolArr_To_Uint (bits);
      end Set;

      -----------
      -- Clear --
      -----------

      procedure Clear (This : in out some_mod_type; bit : bit_number) is
         bitarr : bit_array := Uint_To_BoolArr (This);
      begin
         bitarr (bit) := False;
         This         := BoolArr_To_Uint (bitarr);
      end Clear;

      -----------
      -- Clear --
      -----------

      procedure Clear (This : in out some_mod_type; bits : bit_array) is
         bitarr : bit_array := not bits;
      begin
         bitarr := bitarr and Uint_To_BoolArr (This);
         This   := BoolArr_To_Uint (bitarr);
      end Clear;

      ------------
      -- Toggle --
      ------------

      procedure Toggle (This : in out some_mod_type; bit : bit_number) is
         bitarr : bit_array := Uint_To_BoolArr (This);
      begin
         bitarr (bit) := bitarr (bit) xor True;
         This         := BoolArr_To_Uint (bitarr);
      end Toggle;

      ------------
      -- Toggle --
      ------------

      procedure Toggle (This : in out some_mod_type; bits : bit_array) is
         bitarr : bit_array := Uint_To_BoolArr (This);
      begin
         bitarr := bitarr xor bits;
         This   := BoolArr_To_Uint (bitarr);
      end Toggle;

   end bit_funcs;

   package body Enum_Opts is

      function "*" (Left : Enum; Right : Int) return Int is
      begin
         return Int (Enum'Enum_Rep (Left)) * Right;
      end "*";

      function "*" (Left : Int; Right : Enum) return Int is
      begin
         return Int (Enum'Enum_Rep (Right)) * Left;
      end "*";

      function "/" (Left : Int; Right : Enum) return Int is
      begin
         return Left / Int (Enum'Enum_Rep (Right));
      end "/";

      function Conv (This : Enum) return Int is
      begin
         return Int (Enum'Enum_Rep (This));
      end Conv;

   end Enum_Opts;

   package body Splitt_Unsigned is

      procedure Splitt
        (This : some_mod_type; Low_Bits : out low; High_Bits : out high)
		is
			tmp : some_mod_type := This;
		begin
			--get lower bits
			Low_Bits  := low (This mod
							  (some_mod_type (low'Last) + 1));
			-- remove lower bits from tmp, to calculate the upper bits
			tmp := tmp - some_mod_type(Low_Bits);

			High_Bits := high (tmp /
							 (some_mod_type (low'Last) +1));
      end Splitt;

      function Merge (Low_Bits : low; High_Bits : high) return some_mod_type is
         Result : some_mod_type;
      begin

			Result := some_mod_type (High_Bits)
			  * (some_mod_type (low'Last) +1);
			Result := Result + some_mod_type (Low_Bits);
         return Result;
      end Merge;

   end Splitt_Unsigned;

end helpers;
