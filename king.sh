_king () {
# //enterFight
	PAGE=king
	HPER=50 # //heal on 50% - defaut
	RPER=10 # //random if enemy have +12% hp - default
	ITVL=2.1 # //time for attacks (2.1 ~ 5.O)
	CLSM=( 'king/attack' 'king/attackrandom' 'king/dodge' 'king/heal' 'king/kingatk' 'king/enterGame' )
	echo -e "\n$PAGE"
	echo $URL
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/enterGame -o user_agent="$(shuf -n1 .ua)")
#	SRC=$(lynx -cfg=~/twm/cfg1 -source $URL/$PAGE -useragent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[5]}" | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
# //wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[0]}" | head -n1 | cut -d\' -f2)
	while [[ -z $EXIT ]] ; do
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/enterGame -o user_agent="$(shuf -n1 .ua)")
#		SRC=$(lynx -cfg=~/twm/cfg=1 -source $URL/$PAGE/enterGame -useragent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "$PAGE" | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[0]}" | head -n1 | cut -d\' -f2)
	done
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[2]}" | head -n1 | cut -d\' -f2)
	EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[0]}" | head -n1 | cut -d\' -f2)
	WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white/dred
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
	HEAL=$(expr $FULL \* $HPER \/ 100)
	_show () {
		HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
		HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n3 | tail -1 | cut -d\< -f1 |cut -d\; -f2 | tr -cd '[[:digit:]]')
		echo -e "You: $HP1 - $HP2 :enemy\n$ACCESS"
	}
	_show
# //kingatk - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#	SRC=$(lynx -cfg=~/twm/cfg1 -source "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
	echo $URL
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[4]}" | head -n1 | cut -d\' -f2)
	_show
	EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[0]}" | head -n1 | cut -d\' -f2)
	WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white
	sleep $ITVL
	while [[ -n $EXIT && -n $ACCESS ]] ; do
# //function random - - - - - - - - - - - - - - - - - - - - - - - - - - -
		_random () {
			echo '🔁'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(lynx -cfg=~/twm/cfg1 -source -o "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
			echo $URL
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[1]}" | head -n1 | cut -d\' -f2)
			_show
			EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[0]}" | head -n1 | cut -d\' -f2)
			WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white
			sleep $ITVL
		}
# //function dodge - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		_dodge () {
			echo '🛡️'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(lynx -cfg=~/twm/cfg1 -source "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
			echo $URL
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[2]}" | head -n1 | cut -d\' -f2)
			_show
			EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[0]}" | head -n1 | cut -d\' -f2)
			WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white
			sleep $ITVL
		}
# //heal - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#	    if [[ $WDRED == dred && $HP1 -lt $HEAL ]] ; then
		if [[ $HP1 -lt $HEAL ]] ; then
			echo "🆘 HP < $HPER%"
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(lynx -cfg=~/twm/cfg1 -source "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
			echo $URL
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[3]}" | head -n1 | cut -d\' -f2)
			_show
			EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep "${CLSM[0]}" | head -n1 | cut -d\' -f2)
			WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white
			HP1=$HPFULL
			sleep $ITVL
			_dodge
			_random
# //random - - - - - - - - - - - - - - - - - - - - - - - - - - -
		elif [[ $WDRED == white && `expr $HP1 + $HP1 \* $RPER \/ 100` -lt $HP2 ]] ; then
			_random
			_dodge
# //dodge - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		else
			_dodge
		fi
	done
# //view - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	echo ""
	w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
#	lynx -cfg=~/twm/cfg1 $URL/$PAGE -useragent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
	echo "$PAGE (✔)"
}
