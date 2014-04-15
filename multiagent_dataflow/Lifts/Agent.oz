
declare

fun {NewAgent Process InitState}
   Port Stream
   proc {Serve Messages State}
      case Messages of Message|Next then
         {Serve Next {Process State Message}}
      end
   end
in

   Port={NewPort Stream}
   thread {Serve Stream InitState} end
   proc {$ M} {Send Port M} end
end

/*


*/
