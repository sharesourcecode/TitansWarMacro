_king () {
# //enterFight
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
	HPER=50 # //heal on 50% - defaut
	RPER=11 # //random if enemy have +12% hp - default
	ITVL=2.5 # //time for attacks (2.1 ~ 5.O)
#	CLSM=( 'king/attack' 'king/attackrandom' 'king/dodge' 'king/heal' 'king/kingatk' 'king/enterGame' )
	echo -e "\nKing"
	echo $URL
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/king/enterGame -o user_agent="$(shuf -n1 .ua)")
#	SRC=$(lynx -cfg=~/twm/cfg1 -source $URL/king/enterGame -useragent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
# //wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'king/kingatk/')
	START=`date +%M`
	while [[ -z $EXIT ]] ; do
		END=$(expr `date +%M` \- $START)
		[[ $END -gt 15 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#		SRC=$(lynx -cfg=~/twm/cfg=1 -source "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'king/kingatk/')
	done
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'king/kingatk/' | head -n1 | cut -d\' -f2)
	EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'out_gate')
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
	echo $URL
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'king/dodge' | head -n1 | cut -d\' -f2)
	EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'out_gate')
	WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white
	PRTCT=$(echo $SRC | grep -io '<b>ueliton</b>')
	_show
	sleep $ITVL
	START=`date +%M`
	until [[ -z $EXIT ]] ; do
		END=$(expr `date +%M` \- $START)
		[[ $END -gt 9 ]] && break
# //function random - - - - - - - - - - - - - - - - - - - - - - - - - - -
		_random () {
			echo '🔁'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(lynx -cfg=~/twm/cfg1 -source -o "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
			echo $URL
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'king/attackrandom/' | head -n1 | cut -d\' -f2)
			EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'out_gate')
			WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white
			PRTCT=$(echo $SRC | grep -io '<b>ueliton</b>')
			_show
			sleep $ITVL
		}
# //function dodge - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		_dodge () {
			echo '🛡️'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(lynx -cfg=~/twm/cfg1 -source "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
			echo $URL
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'king/dodge/' | head -n1 | cut -d\' -f2)
			EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'out_gate')
			WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white
			PRTCT=$(echo $SRC | grep -io '<b>ueliton</b>')
			_show
			sleep $ITVL
		}
# //heal - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		if [[ $HP1 -lt $HEAL ]] ; then
			echo "🆘 HP < $HPER%"
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(lynx -cfg=~/twm/cfg1 -source "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
			echo $URL
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'king/heal' | head -n1 | cut -d\' -f2)
			EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'out_gate')
			WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white
			PRTCT=$(echo $SRC | grep -io '<b>ueliton</b>')
			HP1=$HPFULL
			_show
			sleep $ITVL
			_dodge
			_random
# //random - - - - - - - - - - - - - - - - - - - - - - - - - - -
		elif [[ -n $PRTCT || $WDRED == white && `expr $HP1 + $HP1 \* $RPER \/ 100` -lt $HP2 ]] ; then
			_random
			_dodge
# //dodge - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		else
			_dodge
		fi
	done
# //view - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	echo ""
	w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/king -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
#	lynx -cfg=~/twm/cfg1 $URL/king -useragent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
	echo -e "King (✔)"
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
}
