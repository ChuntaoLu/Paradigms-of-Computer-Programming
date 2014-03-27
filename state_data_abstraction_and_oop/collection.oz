declare
class Collection
   attr a
      
   meth init
      a:=nil
   end

   meth put(X)
      a:=X|@a
   end

   meth get($)
      local Head=@a.1 in
         a:=@a.2
         Head
      end
   end

   meth isEmpty($)
      @a==nil
   end

   meth union(C)
      for while:{Not {C isEmpty($)}} do
         a:={C get($)}|@a
      end
   end
   
end

Ca={New Collection init}
Cb={New Collection init}

{Ca put(1)}
{Ca put(3)}
{Cb put(2)}
{Cb put(4)}
{Cb put(6)}
{Browse {Cb get($)}}
{Ca union(Cb)}
{Browse {Ca isEmpty($)}}
{Browse {Cb isEmpty($)}}
