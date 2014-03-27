declare
class Sequence
   attr l

   meth init
      l:=nil
   end

   meth isEmpty($)
      @l==nil
   end
   
   meth first($)
      @l.1
   end

   meth last($)
      local Len={Length @l} in
         {Nth @l Len}
      end
   end

   meth insertFirst(X)
      l:=X|@l
   end

   meth insertLast(X)
      local L Len={Length @l} in
         L=@l
         l:=X|nil
         for I in Len..1;~1 do
            l:={Nth L I}|@l
         end
      end
   end

   meth removeFirst
      l:=@l.2
   end

   meth removeLast
      local L=@l Len={Length @l}-1 in
         l:=nil
         for I in Len..1;~1 do
            l:={Nth L I}|@l
         end
      end
   end
end

fun {Palindrome Xs}
   S={New Sequence init}
   fun {Check}
      if {S isEmpty($)} then true
      else
         if {S first($)}=={S last($)} then
            {S removeFirst}
            {S removeLast}
            {Check}
         else false end
      end
   end
in
   for I in Xs do
      {S insertFirst(I)}
   end
   {Check}
end

{Browse {Palindrome ['s' 'd' 'a']}}
{Browse {Palindrome ['s' 'd' 'a' 'd' 's']}}
{Browse {Palindrome [1 2 3 3 2 1]}}
{Browse {Palindrome [1 2 3 2 1]}}
{Browse {Palindrome nil}}
{Browse {Palindrome ['s']}}
            
