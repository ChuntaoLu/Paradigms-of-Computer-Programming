declare
class Stack
   attr cell

   meth init
      cell:=nil
   end

   meth size($)
      {Length @cell}
   end

   meth isEmpty($)
      @cell==nil
   end

   meth top($)
      if @cell==nil then
         raise topEmptyStack end
      else @cell.1 end
   end

   meth push(X)
      cell:=X|@cell
   end

   meth pop($)
      if @cell==nil then
         raise popEmptyStack end
      else local H in
              H = @cell.1
              cell:=@cell.2
              H
           end
      end
   end
end

local S={New Stack init}  in
   {Browse {S size($)}}
   {Browse {S isEmpty($)}}
   %{Browse {S top($)}}
   {S push(8)}
   {Browse {S size($)}}
   {Browse {S isEmpty($)}}
   {Browse {S top($)}}
   {Browse {S pop($)}}
   %{Browse {S pop($)}}
end
   

         
    
         
         
