%%%
%%% Author:
%%%   Seif Haridi
%%%
%%% Copyright:
%%%   Seif Haridi 2013
%%%
%%%
%%%
%%% Implements the cabins 
%%%


declare

fun {NewEnvironment NoLifts NoFloors}
   %% Drawing related options
   WidthLift   =  80
   HeightFloor = 100
   Gap         =   8
   TextSize    =  32
   %% Time unit
   TimeUnit = 1000
   Delta    = 5
   StepTime = Delta * (TimeUnit div HeightFloor)
   %% Colors
   NormalColor = green
   StopColor   = blue
   
   %% Create window
   local
      F = {New Tk.font tkInit(weight:bold size:18)}
      T = {New Tk.toplevel tkInit(title:'Lift Simulation')}
      W = WidthLift * NoLifts
      H = HeightFloor * NoFloors
   in
      C = {New Tk.canvas tkInit(parent:     T
				width:      W + TextSize
				height:     H + TextSize
				background: white)}
      {Tk.send pack(C)}
      for I in 0..NoLifts-1 do
	 X0=WidthLift*I
	 G2=Gap div 2
      in
	 {C tk(create text
	       X0 + WidthLift div 2 
	       H+TextSize div 2
	       text: 'L'#I+1
	       font: F)}
	 {C tk(create rectangle
	       X0 + G2
	       G2
	       X0 + WidthLift - G2
	       H - G2
	       fill: gray)}
      end
      for I in 0..NoFloors-1 do
	 {C tk(create text
	       W + TextSize div 2
	       HeightFloor*I + HeightFloor div 2
	       text: 'F'#(NoFloors - I)
	       font: F)}
      end
   end

   %% Class for a cabin image
   class CabinImage
      from Tk.canvasTag
      meth init(N)
	 X  = (N-1) * WidthLift
	 X0 = X + Gap
	 X1 = X + WidthLift - Gap
	 Y  = (NoFloors-1) * HeightFloor
	 Y0 = Y + Gap
	 Y1 = Y + HeightFloor - Gap
      in
	 {self tkInit(parent:C)}
	 {C tk(create rectangle X0 Y0 X1 Y1 tag:self fill:NormalColor)}
      end
      
      meth up
	 %% Move image up one floor
	 for I in 1..(HeightFloor div Delta) do
	    {Delay StepTime} {self tk(move 0 ~Delta)}
	 end
      end

      meth down
	 %% Move image down one floor
	 for I in 1..(HeightFloor div Delta) do
	    {Delay StepTime} {self tk(move 0 Delta)}
	 end
      end
      
      meth stop
	 %% Do animation for door opening
	 {self tk(itemconfigure fill:StopColor)}
	 {Delay 5*TimeUnit}
	 {self tk(itemconfigure fill:NormalColor)}
      end
      
   end

   %% Controller for cabin
   proc {NewCabin Lift N}
      %% Send messages to Lift and creates cabin for lift number N
      I = {New CabinImage init(N)}
      proc {Serve Floor}
	 Action
      in
	 {Lift arrived(floor:Floor action:Action)}
	 case Action
	 of wait then {Delay 2*TimeUnit} {Serve Floor}
	 [] up then {I up} {Serve Floor+1}
	 [] down then {I down} {Serve Floor-1}
	 [] stop then {I stop} {Serve Floor}
	 end
      end
   in
      thread {Serve 1} end
   end
in
   NewCabin
end

/*

declare NC={NewEnvironment 3 5}


declare P S P={NewPort S} {NC proc {$ M} {Send P M} end 2}
{Browse S}
S.1.action=stop
S.2.1.action=up
S.2.2.1.action=up
S.2.2.2.1.action=down


*/
