declare
fun {Prefix L1 L2}
   case L1 of
      nil then true
   [] H|T then
      if L2 == nil then false
      else H==L2.1 andthen {Prefix T L2.2} end
   end
end

declare
fun {FindString L1 L2}
   if L2 == nil then {Prefix L1 L2}
   else
      if {Prefix L1 L2} then true
      else {FindString L1 L2.2} end
   end
end

{Browse {Prefix [1 2] [1 2 3]}}
{Browse {Prefix nil [1 2 3]}}
{Browse {Prefix [1] nil}}
{Browse {FindString [1 3] [1 2 3]}}
{Browse {FindString nil nil}}
