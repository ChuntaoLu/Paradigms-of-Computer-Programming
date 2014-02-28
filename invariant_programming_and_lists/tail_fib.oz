declare
fun {TailFib N}
   fun {Fib N Acc1 Acc2}
      case N of
         0 then Acc1
      [] 1 then Acc2
      else {Fib N-1 Acc2 Acc1+Acc2}
      end
   end
in
   {Fib N 0 1}
end

{Browse {TailFib 32}}
{Browse {TailFib 42}}
