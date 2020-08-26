_undying () {
# /enterGame
	echo "Undying"
	w3m -debug $ENC $URL/undying/enterGame -o user_agent="$(shuf -n1 .ua)" | head -n5
#
	echo " 👣 Entering..."
	SRC=$(w3m -debug -dump_source $ENC $URL/undying -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | cut -d\' -f2)
	_access
# /wait
	echo " 😴 Waiting..."
	until [[ -n $MANA ]] ; do
		[[ $(date +%M) = 00 && $(date +%S) > 19 ]] && break
		echo -e " 💤 	..."
		SRC=$(w3m -debug -dump_source $ENC "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | cut -d\' -f2)
		_access
	done
	SRC=$(w3m -debug -dump_source $ENC "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
	_access
	_AtakeHelp
	_fullmana
	_AdeleteEnd
	SRC=$(w3m -debug -dump_source $ENC "$URL/undying" -o user_agent="$(shuf -n1 .ua)")
	_access
	while [[ -n $OUTGATE ]] ; do
		[[ $(date +%M) = 07 ]] && break
		SRC=$(w3m -debug -dump_source $ENC "$URL$HIT" -o user_agent="$(shuf -n1 .ua)")
		_access
		echo -e " 🎲 $HIT"
		sleep 1.4
	done
# /view
	echo ""
	w3m -debug $ENC $URL/undying -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
	echo -e "Undying (✔)"
#	SRC=$(w3m -debug $ENC $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)")
}
