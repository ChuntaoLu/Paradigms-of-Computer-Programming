declare
fun {Reverse L}
   local X in
      {NewCell nil X}
      for Elt in L do
         X:=Elt|@X
      end
      @X
   end
end

{Browse {Reverse [1 2 3 4]}}      
