declare
proc {Split L L1 L2}
   case L of
      nil then L1=nil L2=nil
   [] H|nil then L1=[H] L2=nil
   [] H1|H2|T then
      local M1 M2 in
         L1=H1|M1
         L2=H2|M2
         {Split T M1 M2}
      end
   end
end

fun {Reduction L A B C D}
   local L1 L2 La Lb Lc Ld
      fun {LstSum Lst}
         fun {Sum Lst Acc}
            case Lst of
               nil then Acc
            [] H|T then {Sum T H+Acc}
            end
         end
      in
         case Lst of
            nil then nil
            [] H|T then {Sum H 0}|{LstSum T}
         end
      end
      fun {LstDotLst Lx Ly}
         case Lx of
            nil then 0
         [] H|T then H*Ly.1 + {LstDotLst T Ly.2}
         end
      end
   in
      {Split L L1 L2}
      {Split L1 La Lc}
      {Split L2 Lb Ld}
      {LstDotLst {LstSum [La Lb Lc Ld]} [A B C D]}
   end
end

         
      

proc {TestSplit}
   proc {Test L}
      local L1 L2 in
         {Split L L1 L2}
         {Browse L1}
         {Browse L2}
      end
   end
in
   {Test nil}
   {Test [a0]}
   {Test [a0 a1]}
   {Test [a0 a1 a2]}
   {Test [a0 a1 a2 a3]}
end

{TestSplit}
{Browse {Reduction [1 1 1 1 1] 1 2 3 4}}
