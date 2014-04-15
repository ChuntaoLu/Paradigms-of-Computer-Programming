declare
fun {NewAgent Process InitState}
   Port Stream
in
   Port={NewPort Stream}
   thread
      {FoldL Stream Process InitState _}
   end
   proc {$ M} {Send Port M} end
end

% broadcast function
% needs to be a function so that FoldL can update state
fun {BF State Msg}
   case Msg of init(As) then state(agents:As)
   [] broadcast(M1) then
      for A in State.agents do
         {A M1}
      end
      State
   else State end
end

% brodcaster function
% needs to be a function (not a proc) for FoldL to work
fun {BrowseF S M}
   {Browse (S.name)#M}
   _ % return anything will do
end

% Broadcaster is a port, BF is the process function
% state is the initial state
Broadcaster={NewAgent BF state}
As=for I in 1..10 collect:C do
      {C {NewAgent BrowseF state(name:I)}}
   end
{Broadcaster init(As)}
{Broadcaster broadcast(a)}
