%%%
%%% Author:
%%%   Seif Haridi
%%%
%%% Copyright:
%%%   Seif Haridi, 2003
%%%
%%% Based on Erlang Lift control system in Concurrent Programming in Erlang
%%%  
%%%
%%% Main file for the lift simulation
%%%

\insert 'Agent.oz'
\insert 'Cabin.oz'
\insert 'Lift.oz'
\insert 'Floor.oz'

declare

local

   proc {LinkLifts Ls I NewCabin}
      %% Link lifts to cabins
      case Ls
      of nil then skip
      [] L|Lr then {NewCabin L I} {LinkLifts Lr I+1 NewCabin}
      end
   end

   fun {ForCons I N F}
      %% Create a list with N elements by calling F
      if I=<N then {F I}|{ForCons I+1 N F}
      else nil
      end
   end

in

   fun {NewScenario NoLifts NoFloors}
      NewCabin = {NewEnvironment NoLifts NoFloors}
      Lifts    = {ForCons 1 NoLifts  NewLift}
      /*
      Lifts    = for I in 1..NoLifts collect:C do
		    {C {NewLift I}}
		 end
      */
      
      Floors   = {ForCons 1 NoFloors
		  fun {$ I}
		     {NewFloor I Lifts}
		  end}
      /*
      Floors    = for I in 1..NoFloors collect:C do
		     {C {NewFloor I Lifts}}
		  end
      */
   in
      {LinkLifts Lifts 1 NewCabin}
      scenario(lifts:Lifts floors:Floors)
   end

end


/***************


declare S={NewScenario 4 5}
{Browse S}
declare
[L1 L2 L3 L4] = S.lifts
Ls = S.lifts
[F1 F2 F3 F4 F5] = S.floors
Fs = S.floors

%%%%% User 1 %%%%%%%


declare X1 X2 X3
{L1 stop(floor:1)}
{L2 stop(floor:1)}
{L3 stop(floor:1)}
{L4 stop(floor:1)}
thread {F3 press(up X1)} {Delay 10000} {X1 stop(floor:5)} end
thread {F2 press(up X2)} {Delay 10000} {X2 stop(floor:4)} end
thread {F5 press(down X3)} {Delay 10000} {X3 stop(floor:1)} end

{L1 stop(floor:1)}
{L2 stop(floor:2)}
{L3 stop(floor:1)}
{L4 stop(floor:3)}

{F4 press(up)}
{L1 stop(floor: 5)}
{F3 press(up)}
{L1 stop(floor:5)}
{F4 press(down)}
{L2 stop(floor:2)}
{F2 press(up)}
{L2 stop(floor:4)}
{L3 stop(floor:5)}
{L4 stop(floor:5)}
{L2 stop(floor:5)}
{F4 press(up)}

{L4 stop(floor:4)}
{L4 stop(floor:3)}
{L4 stop(floor:2)}
{L4 stop(floor:1)}

{F1 press(up)}
{L2 stop(floor:4)}
{F2 press(up)}
{F5 press(down)}

{Browse Nth}

thread
   for I in 0..20 do
      {Browse round(I)}
      {{Nth Fs I mod 5 + 1} press(up)}
      {Delay 2000}
   end
end


**************/


