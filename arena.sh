# /arena
function _arena () {
	_clanid
	if [[ -n $CLD ]]; then
		w3m -cookie "$URL/clan/$CLD/quest/take/3" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
		w3m -cookie "$URL/clan/$CLD/quest/help/3" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
		w3m -cookie "$URL/clan/$CLD/quest/take/4" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
		w3m -cookie "$URL/clan/$CLD/quest/help/4" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
	fi
	SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL/arena/" -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'arena/attack' | head -n1 | cut -d\' -f2) #/arena/attack/1/1234567*/
	EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'lab/wizard' | head -n1 | cut -d\' -f2) #/lab/wizard/potion/1234567*/?ref=/arena/
	while [[ -z $EXIT && -n $ACCESS ]]; do
		SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'arena/attack' | head -n1 | cut -d\' -f2) #/arena/attack/1/1234567*/
		echo "$ACCESS"
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'lab/wizard' | head -n1 | cut -d\' -f2) #/lab/wizard/potion/1234567*/?ref=/arena/
	done
	if [[ -n $CLD ]]; then
		w3m -cookie "$URL/clan/$CLD/quest/end/3" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
		w3m -cookie "$URL/clan/$CLD/quest/deleteHelp/3" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
		w3m -cookie "$URL/clan/$CLD/quest/end/4" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
		w3m -cookie "$URL/clan/$CLD/quest/deleteHelp/4" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
	fi
	echo -e "arena (✔)\n"
}
