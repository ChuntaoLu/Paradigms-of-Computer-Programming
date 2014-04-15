declare
fun {Eval Port}
   proc {Process Stream}
      case Stream of Func#Input|Tail then
         {Send Port {Func Input}}
         {Process Tail}
      end
   end
in
   local P S in
      P={NewPort S}
      thread {Process S} end
      P
   end
end

fun {Triple X}
   X*3
end

fun {PlusTwo X}
   X+2
end

% test
local A B C in
   A={NewPort B}
   C={Eval A}
   {Browse B}
   {Send C Triple#4}
   {Send C PlusTwo#6}
   {Send C Triple#3}
end

