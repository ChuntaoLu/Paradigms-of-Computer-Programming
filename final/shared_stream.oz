declare
proc {Add S}
   thread
      case S of r('add' A B R)|T then
         R=A+B
         {Add T}
      [] H|T then {Add T}
      else skip end
   end
end

proc {Sub S}
   thread
      case S of r('sub' A B R)|T then
         R=A-B
         {Sub T}
      [] H|T then {Sub T}
      else skip end
   end
end

proc {Mul S}
   thread
      case S of r('mul' A B R)|T then
         R=A*B
         {Mul T}
      [] H|T then {Mul T}
      else skip end
   end
end

proc {Divi S}
   thread
      case S of r('divi' A B R)|T then
         R=A div B
         {Divi T}
      [] H|T then {Divi T}
      else skip end
   end
end

local S in
   {Add S}
   {Sub S}
   {Mul S}
   {Divi S}
   S = r('add' 1 2 _)|r('sub' 10 5 _)|r('sub' 5 5 _)|_
   {Browse S} % Displays: r('add' 1 2 3)|r('sub' 10 5 5)|r('sub' 5 5 0)|_
end
