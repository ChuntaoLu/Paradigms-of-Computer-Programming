declare
fun {AndG X Y}
   X*Y
end

fun {OrG X Y}
   X+Y-X*Y
end

fun {XorG X Y}
   X+Y-2*X*Y
end

proc {FullAdder X Y Z C S}
   A B D E F
in
   A={AndG X Y}
   B={AndG Y Z}
   D={AndG X Z}
   F={OrG B D}
   C={OrG A F}
   E={XorG X Y}
   S={XorG Z E}
end

fun {ListAdder L1 L2}
   case L1#L2 of nil#nil then
      nil#0
   [] (H1|T1)#(H2|T2) then
      case {ListAdder T1 T2} of Lst#Cin then
         local Cout S in
            {FullAdder H1 H2 Cin Cout S}
            (S|Lst)#Cout
         end
      end
   end
end

%{Browse {ListAdder [0 1 0 1] [1 0 1 0]}}

fun {NFullAdder S1 S2}
   case S1#S2 of (H1|T1)#(H2|T2) then
      {ListAdder H1 H2}|{NFullAdder T1 T2}
   else nil end
end

fun {RandList N}
   if N==0 then nil
   else ({OS.rand} mod 2)|{RandList N-1} end
end

%{Browse {RandList 3}}

fun {Stream N}
   {RandList N}|{Stream N}
end


local S1 S2 S3 in
   S1=[1 1 1 1 1]|[0 0 0 0 0]|[1 1 1 1 0]|_
   S2=[1 1 1 1 1]|[0 0 0 0 0]|[0 0 0 0 1]|_
   %thread S1={Stream 4} end
   %thread S2={Stream 4} end
   thread S3={NFullAdder S1 S2} end
   {Delay 1000}
   {Browse S3}
end

