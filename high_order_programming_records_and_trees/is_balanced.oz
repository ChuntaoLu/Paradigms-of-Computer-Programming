declare
fun {IsBalanced Tree}
   fun{NumLeaves Tree}
      case Tree of
         leaf then 1
      [] btree(T left:L right:R) then {NumLeaves L} + {NumLeaves R}
      end
   end
in
   case Tree of
      leaf then true
   [] btree(T left:L right:R) then {IsBalanced L} andthen {IsBalanced R}
      andthen {Number.abs {NumLeaves L}-{NumLeaves R}}<2 
   end
end

{Browse {IsBalanced btree(a left:leaf
                          right:btree(b left:leaf
                                      right:btree(c left:leaf right:leaf)))}}
{Browse {IsBalanced btree(a left:leaf
                          right:btree(b left:leaf
                                      right:leaf))}}
