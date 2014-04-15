declare
class Tree
   attr
      value
      left
      right

   meth init(V)
      value:=V
      left:=leaf
      right:=leaf
   end

   meth setLeft(T)
      left:=T
   end

   meth setRight(T)
      right:=T
   end

   meth setValue(V)
      value:=V
   end

   meth getLeft($)
      @left
   end

   meth getRight($)
      @right
   end

   meth getValue($)
      @value
   end

   meth isBalanced($)
      fun {NumOfLeaves T}
         case T of leaf then 1
         else {NumOfLeaves {T getLeft($)}}+{NumOfLeaves {T getRight($)}} end
      end
   in
      {Number.abs {NumOfLeaves @left}-{NumOfLeaves @right}}<2
   end

end

local A B C in
   A={New Tree init(4)}
   B={New Tree init(5)}
   C={New Tree init(6)}
   {B setLeft(C)}
   {A setLeft(B)}
   %{Browse {A getValue($)}}
   {Browse {A isBalanced($)}}
   {Browse {B isBalanced($)}}
   {Browse {C isBalanced($)}}
end
   

   
