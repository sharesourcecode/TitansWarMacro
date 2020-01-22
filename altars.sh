_altars () {
# //enterFight
	HPER=49 # //heal on 34% - defaut
	RPER=12 # //random if enemy have +12% hp - default
	ITVL=1.9 # //time for attacks
#	CLSM=( 'altars/attack' 'altars/attackrandom' 'altars/dodge' 'altars/heal' 'altars/leaveFight' 'altars/enterFight' )
	echo -e "\nAltars"
	echo $URL
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/altars/enterFight -o user_agent="$(shuf -n1 .ua)")
#	SRC=$(lynx -cfg=~/twm/cfg1 -source $URL/altars -useragent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'altars/enterFight' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
# //wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'altars/attack/')
	START=`date +%M`
	while [[ -z $EXIT ]] ; do
                END=$(expr `date +%M` \- $START)
                [[ $END -gt 15 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/altars/?close=reward -o user_agent="$(shuf -n1 .ua)")
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/altars/enterFight -o user_agent="$(shuf -n1 .ua)")
#		SRC=$(lynx -cfg=~/twm/cfg=1 -source $URL/altars/enterFight -useragent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/altars/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'altars/attack/')
	done
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'altars/dodge' | head -n1 | cut -d\' -f2)
	EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'altars/attack/')
	WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white/dred
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
	HEAL=$(expr $FULL \* $HPER \/ 100)
	_show () {
		HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
		HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n3 | tail -1 | cut -d\< -f1 |cut -d\; -f2 | tr -cd '[[:digit:]]')
		echo -e "You: $HP1 - $HP2 :enemy\n$ACCESS"
	}
	_show
	START=`date +%M`
	until [[ -z $EXIT ]] ; do
                END=$(expr `date +%M` \- $START)
                [[ $END -gt 5 ]] && break
# //function random - - - - - - - - - - - - - - - - - - - - - - - - - - -
		_random () {
			echo '🔁'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(lynx -cfg=~/twm/cfg1 -source -o "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
			echo $URL
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'altars/grass/' | head -n1 | cut -d\' -f2)
			_show
			EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'altars/attack/')
			WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'altars/stone/' | head -n1 | cut -d\' -f2)
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'altars/attackrandom' | head -n1 | cut -d\' -f2)
			sleep $ITVL
		}
# //function dodge - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		_dodge () {
			echo '🛡️'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(lynx -cfg=~/twm/cfg1 -source "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
			echo $URL
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'altars/dodge' | head -n1 | cut -d\' -f2)
			_show
			EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'altars/attack/')
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
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'altars/heal' | head -n1 | cut -d\' -f2)
			_show
			EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'altars/attack/')
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
	w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/altars -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
#	lynx -cfg=~/twm/cfg1 $URL/altars -useragent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
	echo -e "Altars (✔)"
}
