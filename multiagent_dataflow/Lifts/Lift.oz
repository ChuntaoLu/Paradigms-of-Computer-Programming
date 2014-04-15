%%% Author:
%%%   Seif Haridi
%%%
%%% The lift Agent
%%% Types:
%%%       <Dir> ::= up | down
%%%       <Ans> ::= propose(time:<Int> status:<Status>)
%%%       <Status> ::= reserve | reject
%%%       <Action> ::= wait | stop | down | up
%%%
%%% Request (received) messages:
%%%      request(floor:<Int> dir:<Dir> answer:?<Ans>)
%%%      stop(floor:<Int>)
%%%      arrived(floor:<Int> action:?<Action>)
%%%
%%% Indication (sent) messages:
%%%      propose(time:<Int> status:?<Status>)    
%%% 

/**************  Messages accepted





****************/

declare

local
   TimeMove = 1
   TimeStop = 5
   
   fun {Insert Dir Floor Now Stop}
      case Stop
      of nil  then [Floor]
      [] Next|After then
	 if Next==Floor then Stop
	 elseif Floor==Now then Stop
	 elseif Dir==up andthen Now < Floor andthen Floor < Next then
	    Floor|Stop
	 elseif Dir==down andthen Next < Floor andthen Floor<Now then
	    Floor|Stop
	 else
	    Next|{Insert Dir Floor Next After}
	 end
      end   
   end

%    local
%       fun {DoStop Floor Stop}
% 	 case Stop
% 	 of nil then [Floor]
% 	 [] !Floor|_ then Stop
% 	 [] X|Y|After andthen X<Floor andthen Floor<Y then
% 	    X|Floor|Y|After
% 	 [] X|Y|After andthen Y<Floor andthen Floor<X then
% 	    X|Floor|Y|After
% 	 [] Next|After then
% 	    Next|{DoStop Floor After}
% 	 end
%       end
%    in
%       fun {StopAt Floor Now Stop} S in
% 	 S = {DoStop Floor Now|Stop}
% 	 {Browse stop(S)}
% 	 S
%       end
%    end

   fun {StopAt Floor Now Stop}
      if Floor == Now then Now|Stop
      elseif Floor > Now then 
	 {Insert up Floor Now Stop}
      else
	 {Insert down Floor Now Stop}
      end
   end
   
   fun {WaitTime Dir Floor Now Stop}
      case Stop
      of nil then {Abs Floor-Now}*TimeMove
      [] Next|After then
	 if Next==Floor then
	    {Abs Floor-Now}*TimeMove
	 elseif Dir==up andthen Now=<Floor andthen Floor=<Next then
	    (Floor-Now)*TimeMove
	 elseif Dir==down andthen Now>=Floor andthen Floor>=Next then
	    (Now-Floor)*TimeMove
	 else
	    {WaitTime Dir Floor Next After}+
	    {Abs Now-Next}*TimeMove+TimeStop
	 end
      end
   end
   
   fun {LiftProcess S M}
      Stop  = S.stop
      CurrentFloor   = S.floor
   in
      case M
      of request(floor:Floor dir:Dir answer:?Answer) then
	 Ack
      in
	 Answer = propose(time:{WaitTime Dir Floor CurrentFloor Stop} status:Ack)
	 case Ack
	 of reserve then {AdjoinAt S stop {Insert Dir Floor CurrentFloor Stop}}
	 [] reject  then S
	 end
      [] stop(floor:Floor) then S1 in
	 {Browse stop(floor:Floor)}
	 S1 = {AdjoinAt S stop {StopAt Floor CurrentFloor Stop}}
	 {Browse S1.id#S.stop}
	 S1
      [] arrived(floor:N action:?Continue) then
	 case Stop
	 of nil then
	    Continue = wait
	    {AdjoinAt S floor N}
	 [] Next|After andthen Next==N then
	    Continue = stop
	    {AdjoinAt {AdjoinAt S stop After} floor N}
	 [] Next|_ andthen Next<N then
	    Continue = down
	    {AdjoinAt S floor N}
	 [] Next|_ andthen Next>N then
	    Continue = up
	    {AdjoinAt S floor N}
	 end
      [] id(I) then I = S.id S
      end
   end
in
   fun {NewLift N}
      {NewAgent LiftProcess state(floor:1 stop:nil id:lift(N))}
   end

end

