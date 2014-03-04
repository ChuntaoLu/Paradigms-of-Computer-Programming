declare
 fun {Transform1 L}
    fun {Assign R Fields Values}
       case Fields of
 	 nil then R
       [] H|T then R.H = {Transform1 Values.1} {Assign R T Values.2}
       end
    end
 in
    case L of
       H|(Mh|Mt)|T|nil then
       {Assign {Record.make H Mh|Mt} Mh|Mt T}
    else L end
 end

 fun {Transform2 L}
    fun {Adjoin R Fields Values}
       case Fields of
          nil then R
       [] H|T then {Adjoin {AdjoinAt R H {Transform2 Values.1}} T Values.2}
       end
    end
 in
    case L of
       H|(Mh|Mt)|(Th|Tt)|nil then {Adjoin H(Mh:{Transform2 Th}) Mt Tt}
    else L end
 end
 
    

 {Browse {Transform1 [z [3 a] [b [y [4] [5]]]]}}
 {Browse {Transform2 [z [3 a] [b [y [4] [5]]]]}}
   
