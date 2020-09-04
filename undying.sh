_undying () {
# /enterGame
	echo "Undying"
	w3m -debug $ENC $URL/undying/enterGame -o user_agent="$(shuf -n1 .ua)" | head -n5
#
	echo " 👣 Entering..."
	SRC=$(w3m -debug -dump_source $ENC $URL/undying -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | awk -F\' '{ print $2 }')
	MANA=$(echo $SRC | grep -o 'undying/mana/' | head -n1)
# /wait
	echo " 😴 Waiting..."
	until [[ -n $MANA ]] ; do
		[[ $(date +%M) = 00 && $(date +%S) > 19 ]] && break
		echo -e " 💤 	..."
		SRC=$(w3m -debug -dump_source $ENC "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | awk -F\' '{ print $2 }')
		MANA=$(echo $SRC | grep -o 'undying/mana/' | head -n1)
	done
	SRC=$(w3m -debug -dump_source $ENC "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
	MANA=$(echo $SRC | grep -o 'undying/mana/' | head -n1)
	HIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
#	_AtakeHelp
	_fullmana
#	_AdeleteEnd
	SRC=$(w3m -debug -dump_source $ENC "$URL/undying" -o user_agent="$(shuf -n1 .ua)")
	MANA=$(echo $SRC | grep -o 'undying/mana/' | head -n1)
	HIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
	OUTGATE=$(echo $SRC | grep -o 'out_gate')
	while [[ -n $OUTGATE ]] ; do
		[[ $(date +%M) = 0[78] ]] && break
		SRC=$(w3m -debug -dump_source $ENC "$URL$HIT" -o user_agent="$(shuf -n1 .ua)")
		HIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
		OUTGATE=$(echo $SRC | grep -o 'out_gate')
		echo -e " 🎲 $HIT"
		sleep 1.4
	done
# /view
	echo ""
	w3m -debug $ENC $URL/undying -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC
	echo -e "Undying (✔)"
}
