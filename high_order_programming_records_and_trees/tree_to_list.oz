declare
fun {FromTreeToList T}
   case T of
      leaf then nil
   [] btree(Root left:L right:R) then
      {Append {Append {FromTreeToList L} [Root]} {FromTreeToList R}}
   end
end

{Browse {FromTreeToList btree(42 left:btree(24 left:btree(12 left:leaf right: leaf) 
                                            right:leaf) 
                              right:leaf)}}
