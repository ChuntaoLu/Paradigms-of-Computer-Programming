declare
fun {FromListToTree L}
   fun {Insert Tree Elt}
      case Tree of
         leaf then btree(Elt left:leaf right:leaf)
      [] btree(Root left:L right:R) then if Elt < Root
                                         then btree(Root left:{Insert L Elt} right:R)
                                         else if Elt > Root
                                              then btree(Root left:L right:{Insert R Elt})
                                              else Tree end
                                         end
      end
   end

   fun {ListToTree Tree List}
      case List of
         nil then Tree
      [] H|T then {ListToTree {Insert Tree H} T}
      end
   end
in
   {ListToTree leaf L}
end


{Browse {FromListToTree [42 42 24 12 28 51 49 77]}}
