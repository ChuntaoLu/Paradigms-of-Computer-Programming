%%% Author:
%%%   Seif Haridi
%%%
%%% The Floor agent 
%%% Types:
%%%       <Dir> ::= up | down
%%%       <A> ::= propose(time:<Int> status:<B>)
%%%       <B> ::= reserve | reject
%%%
%%% Request (received) messages: 
%%%       press(<Dir>)
%%%       press(<Dir>, ?Lift)
%%%
%%% Indication (sent) messages:
%%%      request(floor:<Int> dir:<Dir> answer:?<A>)
%%% 



declare

local

   proc {Select As B}
      case As
      of nil then
	 B.status = reserve
      [] A|Ar then
	 if A.time < B.time then
	    B.status = reject {Select Ar A}
	 else
	    A.status = reject {Select Ar B}
	 end
      end
   end
   local
      fun {In Xs P I}
	 case Xs
	 of nil then {Browse error(I)} I
	 [] X|_ andthen {P X} then I
	 [] _|Xr then {In Xr P I+1}
	 end
      end
   in
      fun {Index Xs P} {In Xs P 1} end
   end

   fun {SelectLift As Ls}
      {Select As.2 As.1}
      {Nth Ls {Index As fun{$ A} A.status==reserve end}}
   end

   fun {FloorProcess S M}
      Floor = S.floor
      Lifts = S.lifts
   in
      case M
      of press(Dir) then
	 As = {Map Lifts
	       fun {$ L}
		  A
	       in
		  {L request(floor:Floor dir:Dir answer:?A)} A
	       end}
      in
	 {Select As.2 As.1} S
      [] press(Dir Lift) then
	 As = {Map Lifts
	       fun {$ L}
		  A
	       in
		  {L request(floor:Floor dir:Dir answer:?A)} A
	       end}
      in
	 Lift = {SelectLift As Lifts} S
      end
   end

in

   fun {NewFloor N Lifts}
      {NewAgent FloorProcess
       state(floor:N lifts:Lifts id:floor(N))}
   end
   
end
