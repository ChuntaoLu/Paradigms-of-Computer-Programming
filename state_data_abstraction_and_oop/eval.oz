declare
fun {NewStack} {NewCell nil} end
fun {IsEmpty S} @S==nil end
proc {Push S X} S:=X|@S end
fun {Pop S}
   local Out=@S.1 in
      S:=@S.2
      Out
   end
end


fun {Eval L}
   local Stack Result in
      Stack={NewStack}
      Result={NewStack}
      for I in {Length L}..1;~1 do
         {Push Stack {Nth L I}}
      end
      for while:{Not {IsEmpty Stack}} do
         local Elt in
            Elt={Pop Stack}
            case Elt of
               '+' then {Push Result {Pop Result}+{Pop Result}}
            [] '*' then {Push Result {Pop Result}*{Pop Result}}
            [] '-' then {Push Result ~{Pop Result}+{Pop Result}}
            [] '/' then
               local X Y in
                  X={Pop Result}
                  Y={Pop Result}
                  {Push Result Y div X}
               end
            else {Push Result Elt} end
         end
      end
      {Pop Result}
   end
end

{Browse {Eval [2 3 '+' 4 '*' 10 '/']}}
