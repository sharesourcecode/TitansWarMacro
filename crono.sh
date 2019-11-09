# //time - - - - - - - - - - - - - - - - - - - - - - - - - - -
_crono () {
	HOUR1=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL" -o user_agent="$(shuf -n1 .ua)" | sed 's/--/\n/g' | grep '/online/' | cut -d\: -f1 | tr -cd '[:digit:]')
	[[ $HOUR1 = 00 ]] && HOUR=0
	[[ $HOUR1 = 01 ]] && HOUR=1
	[[ $HOUR1 = 02 ]] && HOUR=2
	[[ $HOUR1 = 03 ]] && HOUR=3
	[[ $HOUR1 = 04 ]] && HOUR=4
	[[ $HOUR1 = 05 ]] && HOUR=5
	[[ $HOUR1 = 06 ]] && HOUR=6
	[[ $HOUR1 = 07 ]] && HOUR=7
	[[ $HOUR1 = 08 ]] && HOUR=8
	[[ $HOUR1 = 09 ]] && HOUR=9
	MIN1=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL" -o user_agent="$(shuf -n1 .ua)" | sed 's/--/\n/g' | grep '/online/' | cut -d\: -f2 | tr -cd '[:digit:]')
	[[ $MIN1 = 00 ]] && MIN=0
	[[ $MIN1 = 01 ]] && MIN=1
	[[ $MIN1 = 02 ]] && MIN=2
	[[ $MIN1 = 03 ]] && MIN=3
	[[ $MIN1 = 04 ]] && MIN=4
	[[ $MIN1 = 05 ]] && MIN=5
	[[ $MIN1 = 06 ]] && MIN=6
	[[ $MIN1 = 07 ]] && MIN=7
	[[ $MIN1 = 08 ]] && MIN=8
	[[ $MIN1 = 09 ]] && MIN=9
	echo -e "\n $URL ⏰ $HOUR1:$MIN1\n"
}
