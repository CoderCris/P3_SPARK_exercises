package body Searching with SPARK_Mode is

   function Minimum (Table : T_Table) return Integer is
   --  Returns the smallest value stored in the table

      minVal : Integer := Integer'Last;
   begin
      --  if Table'Length = 1 then
      --     return Table(Table'First);
      --  end if;

      for J in Table'Range loop
         if Table(J) < minVal then
            minVal := Table(J);
         end if;

         pragma Loop_Invariant
           (for all K in Table'First .. J =>
              Table(K) >= minVal);

      end loop;
      return minVal;
   end Minimum;


   --  function Pos_Minimum (Table : T_Table) return Natural is
   --     --  Returns the index of the smallest element of Table
   --
   --     minPos : Natural := Table'First;
   --     J : Natural := Table'First;
   --  begin
   --     while J <= Table'Last loop
   --        if Table(J) < Table(minPos) then
   --           minPos:= J;
   --        end if;
   --        J := J+1;
   --
   --        pragma Loop_Variant(Increases => J);
   --        pragma Loop_Invariant
   --          (for some K in Table'First .. J-1 =>
   --             minPos = K);
   --        --  pragma Loop_Invariant
   --        --    (for all K in J .. Table'Last =>
   --        --    minPos /= K);
   --     end loop;
   --     return minPos;
   --  end Pos_Minimum;




   --  function Linear_Search
   --    (Table : T_Table; Value : Integer) return Integer;
   --  --  Searchs for Value performing a linear search and returns
   --  --  its index in the given table; returns Integer'First if the
   --  --  specified value is not found in the table.
   --
   --
   --  function Binary_Search_Recursive
   --    (Table: T_Table; Value: Integer) return Integer;
   --

   function Binary_Search
     (Table: T_Table; Value: Integer) return Integer is
      low : natural := Table'First;
      high : natural := Table'Last;
      mid: natural := low+high/2;
   begin

      while low <= high loop
         --if Table(mid) = Value return mid;
         if Table(mid) > Value then
            high := mid-1;
            mid := low+high/2;
         elsif Table(mid) < Value then
            low := mid+1;
            mid := low+high/2;
         else
            return mid;
         end if;

         pragma Loop_Variant(Decreases => high);
         pragma Loop_Variant(Increases => low);
         pragma Loop_Invariant( mid >= low);
         pragma Loop_Invariant(mid <= high);
         pragma Loop_Invariant(low <= high);
      end loop;
      return Table'First;
   end Binary_Search;

end Searching;
