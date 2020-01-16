# //undying - -- - - - - - - - - - - - - - - - - - - - - - - - -
function _undying () {
#	ARENA="$(w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | cut -d\/ -f5 | tr -cd "[[:digit:]]")" && w3m -debug -o accept_encoding=='*;q=0' "$URL/arena/attack/1/$ARENA/?fullmana=true" -o user_agent="$(shuf -n1 .ua)" | grep "\[1"
# //enterGame
	PAGE=undying
	echo "$PAGE"
	w3m -debug -o accept_encoding=='*;q=0' $URL/$PAGE/enterGame -o user_agent="UA" | head -n10 | tail -n6 | sed "/\[2hit/d;/\[str/d;/combat/d"
	sleep 5
# //
	echo " 👣 Entering..."
	SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$(shuf -n1 .ua)"`
# //wait
	echo " 😴 Waiting..."
	EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep '\/mana\/' | cut -d\/ -f2`
	while [[ -z $EXIST && $MIN = 00 ]]; do
		SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$(shuf -n1 .ua)"`
		EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep '\/mana\/' | cut -d\/ -f2`
		echo -e " 💤 	..."
	done
# //
	ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "mana\/" | cut -d\/ -f3`
	SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/mana/$ACCESS -o user_agent="$(shuf -n1 .ua)"`
	sleep 3
	ARENA="$(w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | cut -d\/ -f5 | tr -cd "[[:digit:]]")" && w3m -debug -o accept_encoding=='*;q=0' "$URL/arena/attack/1/$ARENA/?fullmana=true&heal=true" -o user_agent="$(shuf -n1 .ua)" | grep "\[1"
	SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$(shuf -n1 .ua)"`
	ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "hit\/" | cut -d\/ -f3`
	EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep '\/hit\/' | cut -d\/ -f2`
	while [[ $EXIST == hit ]]; do
		echo -e " 🎲 hiting..."
		SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/hit/$ACCESS -o user_agent="$(shuf -n1 .ua)"`
		ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "hit\/" | cut -d\/ -f3`
		EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "hit\/" | cut -d\/ -f2`
		sleep 2.7
	done
}
