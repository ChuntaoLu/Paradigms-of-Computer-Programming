declare
fun {AppendLists L1 L2}
   case L1 of
      nil then L2
   [] H|T then H|{AppendLists T L2}
   end
end

{Browse {AppendLists [4] [1 2 3]}}
{Browse {AppendLists [5 [6]] [1 2 3]}}
