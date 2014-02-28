declare
fun {Prime N}
   fun {IsPrime N Acc}
      if Acc==1 then true
      else
         if N mod Acc == 0 then false
         else {IsPrime N Acc-1} end
      end
   end
in
   if N==1 then false
   else {IsPrime N N-1} end
end


{Browse {Prime 1}}   
{Browse {Prime 2}}   
{Browse {Prime 13}}   
{Browse {Prime 50}}   
