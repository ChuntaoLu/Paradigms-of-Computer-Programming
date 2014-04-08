declare
proc {ForCollect Xs P Ys}
   Acc={NewCell Ys}
   proc {C X} R2 in @Acc=X|R2 Acc:=R2 end
in
   for X in Xs do {P C X} end
   @Acc=nil
end

local R in
   R={ForCollect [1 2 3 4 5] proc {$ C X} if X==1 then {C 2} else {C X*X} end end}
   {Browse R}
end

