declare P S
P={NewPort S}
{Browse S}
for E in S do
   {Browse E}
   case E of pair(r X) then X=ok
   else skip end
end

{Send P 1}
{Send P 2}

   
declare X
{Browse X}
{Send P pair(r X)}
{Send P pair(r _)}
{Send P notpair(r _)}
