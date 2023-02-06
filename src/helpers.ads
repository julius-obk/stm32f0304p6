with System;
package helpers is

	generic
		type some_mod_type is mod <>;
	package bit_funcs is
		subtype bit_number is some_mod_type range 1 .. some_mod_type'Size;
		type bit_array is array (bit_number) of Boolean;
		for bit_array'Component_Size use 1;

		procedure Set (This : in out some_mod_type; bit : bit_number);
		procedure Set (This : in out some_mod_type; bits : bit_array);
		procedure Clear (This : in out some_mod_type; bit : bit_number);
		procedure Clear (This : in out some_mod_type; bits : bit_array);
		procedure Toggle (This : in out some_mod_type; bit : bit_number);
		procedure Toggle (This : in out some_mod_type; bits : bit_array);
	end bit_funcs;

	generic
		type Enum is (<>);
		type Int is range <>;
	package Enum_Opts is
		function "*" (Left : Enum; Right : Int) return Int;
		function "*" (Left : Int; Right : Enum) return Int;
		function "/" (Left : Int; Right : Enum) return Int;
		function Conv (This : Enum) return Int;
	end Enum_Opts;

	generic
		type some_mod_type is mod <>;  -- splitt this type into to unsiged parts low and high
		type low is mod <>; --lower part
		type high is mod <>; -- higher part
	package Splitt_Unsigned is
		pragma Compile_Time_Warning
		  (some_mod_type'Size /= low'Size + high'Size,
	  "this bit size of type some_mod_Type must match the bit size of low + high");
		--  type Overlay is record
		--  	Low_Bits : low;
		--  	High_Bits : high;
		--  end record
		--    with Volatile_Full_Access, Size => some_mod_type'Size,
		--    Bit_Order => System.Low_Order_First;
		--
		--  for Overlay use record
		--  	Low_Bits at 0 range 0 .. (low'Size -1);
		--  	High_Bits  at 0 range low'Size ..
		--  	  low'Size + high'Size -1;
		--  end record;
		--
		procedure Splitt(This : some_mod_type;
						 Low_Bits : out low;
						 High_Bits : out high);
		function Merge(Low_Bits : low; High_Bits : high) return some_mod_type;
	end Splitt_Unsigned;





end helpers;
