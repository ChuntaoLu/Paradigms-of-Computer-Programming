declare
fun {FlattenList L}
   case L of
      nil then L
   [] H|T then
      case H of
         HH|HT then {Append {FlattenList H} {FlattenList T}}
      else H|{FlattenList T}
      end
   end
end

{Browse {FlattenList [[1 2] [1 [2]]]}}
{Browse {FlattenList [[1 2 [3 [4[5]]]] [1 [2]]]}}
