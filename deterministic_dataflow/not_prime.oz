declare
fun {Prod Start End}
   if Start > End then nil
   else Start|{Prod Start+1 End} end
end

fun {Stream Start}
   Start|{Stream Start+1}
end

fun {Filter Stream K}
   case Stream of H|T then
      if H mod K == 0 then {Filter T K}
      else H|{Filter T K} end
   else nil end
end


fun {Sieve S}
   case S of H|T then
      %{Delay 1000}
      %{Browse H}
      %because of thread it works when S is a stream
      H|{Sieve thread {Filter T H} end}
      %below works when S is a list, but not when S is a Stream
      %H|{Sieve {Filter T H}} 
   else nil end
end

fun {NotPrime S1 S2}
   case S1 of H1|T1 then
      case S2 of H2|T2 then
         if H1==H2 then {NotPrime T1 T2}
         else H1|{NotPrime T1 S2} end
      else S1 end
   else nil end
end

local X Y Z in
   thread X={Prod 2 60} end
   %thread X={Stream 2} end
   thread Y={Sieve X} end
   Z={NotPrime X Y}
   {Browse Z}
end
