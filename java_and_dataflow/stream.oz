declare
proc {Disp S}
   case S of H|T then {Browse H} {Disp T} end
end

fun {Prod N}
   {Delay 1000}
   N|{Prod N+1}
end

fun {Trans S}
   case S of N|T then
      N*N|{Trans T}
   end
end


declare S S2
thread S={Prod 1} end
thread S2={Trans S} end
thread {Disp S2} end

%declare S2 in S=a|b|c|S2
%declare S3 in S2=d|e|f|s3
