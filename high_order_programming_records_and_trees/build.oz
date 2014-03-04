local
   F
   fun {Build D C}
      fun {Out X D C}
         case D of
            H|T then if X==H then C.1 else {Out X T C.2} end
         else 'bottom' end
      end
   in
      fun {$ X} {Out X D C} end
   end
in 
   F = {Build [1 2 3] ['a' 'b' 'c']}
   {Browse {F 1}}
   {Browse {F 2}}
   {Browse {F 3}}
end
