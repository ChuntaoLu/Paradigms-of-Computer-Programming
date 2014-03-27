declare
fun {Shuffle L}
   local Array Len Cell in
      Cell={NewCell nil}
      Len={Length L}
      Array={NewArray 1 Len 0}
      for I in 1..Len do
         Array.I:={Nth L I}
      end
      for J in Len..1;~1 do
         local R Swap in
            R={OS.rand} mod J + 1
            Swap=Array.R
            Array.R:=Array.J
            Array.J:=Swap
         end
         Cell:=Array.J|@Cell
      end
      @Cell
   end
end

{Browse {Shuffle [1 2 3 4]}}
{Browse {Shuffle [1 4]}}
