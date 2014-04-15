declare
fun {DivIfNot5 N T}
   if (T mod 5)==0 then error5
   else N div T end
end

fun {DivIfNot4 N T}
   X in
   X={DivIfNot5 N T-1}
   if (T mod 4)==0 then error4
   else if X==error5 then
           X
        else X div T end
   end
end

fun {DivIfNot3 N T}
   X in
   X={DivIfNot4 N T-1}
   if (T mod 3)==0 then error3
   else if X==error4 then
           X
        else X div T end
   end
end

fun {DivIfNot5E N T}
   if (T mod 5)==0 then raise mod0By5(error5) end
   else N div T end
end

fun {DivIfNot4E N T}
   X in
   X={DivIfNot5E N T-1}
   if (T mod 4)==0 then raise mod0By4(error4) end
   else X div T end
end

fun {DivIfNot3E N T}
   X in
   X={DivIfNot4E N T-1}
   if (T mod 3)==0 then raise mod0By3(error3) end
   else X div T end
end


{Browse {DivIfNot4E 60 3}}
                           
