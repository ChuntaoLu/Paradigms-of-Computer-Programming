declare
fun {Producer N}
   fun {Prod M}
      if M<N+1 then M|{Prod M+1}
      else nil end
   end
in
   {Prod 1}
end

fun {Filter S}
   case S of H|T then
      if (H mod 2)==1 then H|{Filter T}
      else {Filter T} end
   else nil end
end

fun {Consumer S}
   case S of H|T then
      H+{Consumer T}
   else 0 end
end

proc {Disp S}
   case S of H|T then
      {Browse H}
      {Disp T}
   end
end
  

local P F in
   thread P={Producer 20} end
   thread F={Filter P} end
   %thread {Disp F} end
   thread {Browse {Consumer F}} end
end
