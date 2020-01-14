_undying () {
# //enterFight
	PAGE=undying
	ITVL=5.5 # //time for hits
	CLSM=( 'undying/hit' 'undying/mana' )
	echo -e "\n$PAGE"
	echo $URL
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/enterGame -o user_agent="$(shuf -n1 .ua)")
#	SRC=$(lynx -cfg=~/twm/cfg1 -source $URL/$PAGE -useragent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[1]}" | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
# //wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[1]}" | head -n1 | cut -d\' -f2)
	while [[ -z $EXIT && -z $ACCESS ]] ; do
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/${CLSM[1]} -o user_agent="$(shuf -n1 .ua)")
#		SRC=$(lynx -cfg=~/twm/cfg=1 -source $URL/${CLSM[1]} -useragent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[1]}" | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[0]}" | head -n1 | cut -d\' -f2)
	        SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/enterGame -o user_agent="$(shuf -n1 .ua)")
		sleep $ITVL
	done
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[0]}" | head -n1 | cut -d\' -f2)
	EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[0]}" | head -n1 | cut -d\' -f2)
	_show () {
		HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
		echo -e "HP: $HP1\n$ACCESS"
	}
	_show
	while [[ -n $EXIT && -n $ACCESS ]] ; do
# //function hit - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		_hit () {
			echo '🛡️'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(lynx -cfg=~/twm/cfg1 -source "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
			echo $URL
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[0]}" | head -n1 | cut -d\' -f2)
			_show
			EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[0]}" | head -n1 | cut -d\' -f2)
			sleep $ITVL
		}
# //hit - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		_hit
	done
# //view - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	echo ""
	w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d"
#	lynx -cfg=~/twm/cfg1 $URL/$PAGE -useragent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
	echo "$PAGE (✔)"
}
