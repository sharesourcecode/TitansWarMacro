# //arena - - - - - - - - - - - - - - - - - - - - - - - - - - -
function _arena () {
	PAC=( 'arena/attack' 'lab/wizard' ) #Page:Action:Condition
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/${PAC[0]:0:5}" -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "${PAC[0]}" | head -n1 | cut -d\' -f2) #/arena/attack/1/1234567*/
	EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${PAC[1]}" | head -n1 | cut -d\' -f2) #/lab/wizard/potion/1234567*/?ref=/arena/
	while [[ -z $EXIT ]]; do
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "${PAC[0]}" | head -n1 | cut -d\' -f2) #/arena/attack/1/1234567*/
		echo "$ACCESS"
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${PAC[1]}" | head -n1 | cut -d\' -f2) #/lab/wizard/potion/1234567*/?ref=/arena/
	done
}