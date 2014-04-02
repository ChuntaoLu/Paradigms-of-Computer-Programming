declare
fun {Reverse S}
   local I={NewCell S} in
      local Temp={NewCell nil} in
         for C in @I do
            Temp:=C|@Temp
         end
         @Temp
      end
   end
end

{Browse {Reverse [1 2 3 4]}}
{Browse {Reverse nil}}
