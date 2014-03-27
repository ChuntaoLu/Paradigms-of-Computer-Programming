declare
class Addition
   attr x y
   meth init(X Y)
      x:=X
      y:=Y
   end
   meth evaluate(Result)
      local Xresult Yresult in
         {@x evaluate(Xresult)}
         {@y evaluate(Yresult)}
         Result=Xresult+Yresult
      end
   end
end

class Subtraction
   attr x y
   meth init(X Y)
      x:=X
      y:=Y
   end
   meth evaluate(Result)
      local Xresult Yresult in
         {@x evaluate(Xresult)}
         {@y evaluate(Yresult)}
         Result=Xresult-Yresult
      end
   end
end

class Multiplication
   attr x y
   meth init(X Y)
      x:=X
      y:=Y
   end
   meth evaluate(Result)
      local Xresult Yresult in
         {@x evaluate(Xresult)}
         {@y evaluate(Yresult)}
         Result=Xresult*Yresult
      end
   end
end

class Division
   attr x y
   meth init(X Y)
      x:=X
      y:=Y
   end
   meth evaluate(Result)
      local Xresult Yresult in
         {@x evaluate(Xresult)}
         {@y evaluate(Yresult)}
         Result=Xresult div Yresult
      end
   end
end

class Constant
   attr v
   meth init(Value)
      v:=Value
   end
   meth evaluate(Result)
      Result=@v
   end
end

class Variable
   attr v
   meth init(Value)
      v:=Value
   end
   meth set(NewValue)
      v:=NewValue
   end
   meth evaluate(Result)
      Result=@v
   end
end

VarX = {New Variable init(0)}
VarY = {New Variable init(0)}
local
   Result
   C = {New Constant init(6)}
   Expr1 = {New Addition init(VarX VarY)}
   Expr2 = {New Division init(Expr1 C)}
in
   {VarX set(3)}
   {VarX set(4)}
   {Expr2 evaluate(Result)}
   {Browse Result}
end

