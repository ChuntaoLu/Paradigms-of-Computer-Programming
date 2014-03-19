declare
proc {Fact N A R} 
   local B in 
      B=(N==0) 
      if B then R=A 
      else local N1 A1 in 
              N1=N-1 
              A1=A*N
              {Fact N1 A1 R} 
           end 
      end 
   end 
end

local R in
   {Fact 4 1 R}
   {Browse R}
end
