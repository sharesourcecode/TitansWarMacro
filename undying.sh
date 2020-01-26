_undying () {
# //enterGame
	echo "Undying"
	w3m -debug -o accept_encoding=='*;q=0' $URL/undying/enterGame -o user_agent="$(shuf -n1 .ua)" | head -n5
	sleep 2
# //
	echo " 👣 Entering..."
	SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/undying -o user_agent="$(shuf -n1 .ua)")
# //wait
	echo " 😴 Waiting..."
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | cut -d\' -f2)
	EXIT=$(echo $SRC | grep -o 'undying/mana')
	START=`date +%M`
	sleep 2
#
	while [[ -z $EXIT ]] ; do
		END=$(expr `date +%M` \- $START)
		[[ $END -gt 15 ]] && break
		SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed "s/href=/\n/g" | grep '/undying/' | cut -d\' -f2 | head -n1)
		EXIT=$(echo $SRC | grep -o 'undying/mana/')
		echo -e " 💤 	..."
	done
#
	sleep 1
	SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#	ACCESS=$(echo $SRC | sed 's/href=/\n/g'  | grep 'undying/mana/' | head -n1 | cut -d\' -f2)
#	SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g'  | grep 'undying/hit/' | head -n1 | cut -d\' -f2)
	EXIT=$(echo $SRC | grep -o 'hit/out_gate')
	START=`date +%M`
	while [[ -n $EXIT ]] ; do
		END=$(expr `date +%M` \- $START)
		[[ $END -gt 5 ]] && break
		echo -e " 🎲 hiting..."
		SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | grep -o 'hit/out_gate')
		sleep 5
	done
}
