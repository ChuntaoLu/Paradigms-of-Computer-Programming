declare
fun {ListFact L}
   fun {Fact N Acc}
      if N<2 then Acc
      else {Fact N-1 N*Acc} end
   end
in
   case L of
      nil then nil
   [] H|T then {Fact H 1}|{ListFact T}
   end
end

{Browse {ListFact [1 2 3]}}
{Browse {ListFact [7 6 15]}}
