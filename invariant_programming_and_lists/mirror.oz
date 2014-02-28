declare
fun {MainMirror N}
   fun {Mirror N Acc}
      if N==0 then Acc
      else {Mirror (N div 10) Acc*10+(N mod 10)} end
   end
in
   {Mirror N 0}
end

{Browse {MainMirror 1234}}
{Browse {MainMirror 876465}}
