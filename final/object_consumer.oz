declare
class List
   attr list

   meth init(L)
      list:=L
   end

   meth isEven(I $)
      {Nth @list I+1} mod 2 == 0
   end

   meth get(I $)
      {Nth @list I+1}
   end

   meth getList($)
      @list
   end
end


fun {Producer M N}
   fun {Mrand X}
      if X == 0 then nil
      else {OS.rand}|{Mrand X-1} end
   end
in
   if N == 0 then nil
   else {New List init({Mrand M})}|{Producer M N-1} end
end
   
fun {Filter S J}
   case S of H|T then
      if {H isEven(J $)} then H|{Filter T J}
      else {Filter T J} end
   else nil end
end

fun {Consumer P S1 S2}
   case S1#S2 of (H1|T1)#(H2|T2) then
      if {H1 get(P $)} < {H2 get(P $)} then H1|H2|{Consumer P T1 T2}
      else H2|H1|{Consumer P T1 T2} end
   else nil end
end

L1 = {New List init([1 2 3])}
{Browse {L1 get(0 $)}}

L2 = {Producer 3 3}
{Browse {Filter L2 1}}
   
