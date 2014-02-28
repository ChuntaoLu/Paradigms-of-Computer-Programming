declare
fun {NaiveFib N}
   case N of
      0 then 0
   [] 1 then 1
   else {NaiveFib N-1} + {NaiveFib N-2}
   end
end

{Browse {NaiveFib 32}}
