declare
fun {Infix Tree}
   case Tree of
      btree(X left:Y right:Z) then {Append {Append {Infix Y} [X]} {Infix Z}}
   [] leaf then nil
   end
end

{Browse {Infix btree(4 left:btree(2 left:btree(1 left:leaf right:leaf)
                                  right:btree(3 left:leaf right:leaf)) 
                     right:btree(5 left:leaf right:leaf))}}
