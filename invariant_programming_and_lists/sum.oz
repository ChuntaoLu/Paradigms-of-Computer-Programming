declare
fun {MainSum N}
   fun {Sum N Acc}
      if N==0 then Acc
      else {Sum N-1 N+Acc} end
   end
in
   {Sum N 0}
end

{Browse {MainSum 10}}
{Browse {MainSum 5}}
