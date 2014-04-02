declare
fun {Counter S}
   fun {Count Lst M}
      case Lst of
         nil then [M#1]
      [] X#Y|T then
         if X==M then X#(Y+1)|T
         else X#Y|{Count T M} end
      end
   end
   local Cell={NewCell nil} in
      fun {Consume Stream}
         case Stream of H|T then
            Cell:={Count @Cell H}
            @Cell|{Consume T}
         else _ end
      end
   end
in
   thread {Consume S} end
end

local InS X in
   X={Counter InS}
   InS=a|b|a|c|_
   {Delay 2000}
   {Browse X}
end
