# //clandungeon - - - - - - - - - - - - - - - - - - - - - - -
function _clandungeon () {
	if [[ -n $CLD ]]; then
		echo "Checking Clan Dungeon..."
		SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/clandungeon/?close" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed "s/clandungeon/\\n/g" | grep "attack" | cut -d\/ -f3 | shuf -n1)
		EXIST=$(echo $SRC | sed "s/clandungeon/\\n/g" | grep "attack" | cut -d\/ -f2 | shuf -n1)
		while [[ $EXIST == attack ]]; do
			SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/clandungeon/attack/$ACCESS" -o user_agent="$(shuf -n1 .ua)")
			ACCESS=$(echo $SRC | sed "s/clandungeon/\\n/g" | grep "attack" | cut -d\/ -f3 | shuf -n1)
			EXIST=$(echo $SRC | sed "s/clandungeon/\\n/g" | grep "attack" | cut -d\/ -f2 | shuf -n1)
			echo " ⚔ $ACCESS"
		done
		echo -e "Clan Dungeon (✔)\n"
	fi
}
