_clanfight () {
# //enterFight
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
	HPER=49 # //heal on 34% - defaut
	RPER=12 # //random if enemy have +12% hp - default
	ITVL=0.9
	echo -e "\nClan fight"
	echo $URL
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/clanfight/?close=reward -o user_agent="$(shuf -n1 .ua)")
#	SRC=$(lynx -cfg=~/twm/cfg1 -source $URL/clanfight -useragent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'clanfight/enterFight' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
# //wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | grep -o 'clanfight/attack/')
	START=`date +%M`
	while [[ -z $EXIT ]] ; do
                END=$(expr `date +%M` \- $START)
                [[ $END -gt 15 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
#		SRC=$(lynx -cfg=~/twm/cfg=1 -source "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/clanfight/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | grep -o 'clanfight/attack/')
	done
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
	_show () {
		HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
		HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n3 | tail -1 | cut -d\< -f1 |cut -d\; -f2 | tr -cd '[[:digit:]]')
		echo $URL
		echo -e "You: $HP1 - $HP2 :enemy\n"
	}
	_cfaccess () {
		ATK=$(echo $SRC | sed 's/href=/\n/g' | grep 'clanfight/attack/' | head -n1 | cut -d\' -f2)
		ATKRND=$(echo $SRC | sed 's/href=/\n/g' | grep 'clanfight/attackrandom/' | head -n1 | cut -d\' -f2)
		DDG=$(echo $SRC | sed 's/href=/\n/g' | grep 'clanfight/dodge/' | head -n1 | cut -d\' -f2)
		HL=$(echo $SRC | sed 's/href=/\n/g' | grep 'clanfight/heal/' | head -n1 | cut -d\' -f2)
		STN=$(echo $SRC | sed 's/href=/\n/g' | grep 'clanfight/stone/' | head -n1 | cut -d\' -f2)
		GRSS=$(echo $SRC | sed 's/href=/\n/g' | grep 'clanfight/grass/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | grep -o 'clanfight/attack/')
		WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white/dred
		PRTCT=$(echo $SRC | grep -io '<b>ueliton</b>')
		HEAL=$(expr $FULL \* $HPER \/ 100)
		_show
	}
	_cfaccess
	START=`date +%M`
	until [[ -z $EXIT ]] ; do
                END=$(expr `date +%M` \- $START)
                [[ $END -gt 5 ]] && break
# //function random
		_random () {
			sleep $ITVL
			echo '🔁'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ATKRND" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(lynx -cfg=~/twm/cfg1 -source -o "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
			_cfaccess
			sleep $ITVL
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$GRSS" -o user_agent="$(shuf -n1 .ua)")
			_cfaccess
			sleep $ITVL
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$STN" -o user_agent="$(shuf -n1 .ua)")
			_cfaccess
		}
# //function dodge
		_dodge () {
			sleep $ITVL
			echo '🛡️'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$DDG" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(lynx -cfg=~/twm/cfg1 -source "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
			_cfaccess
			sleep $ITVL
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$GRSS" -o user_agent="$(shuf -n1 .ua)")
			_cfaccess
			sleep $ITVL
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$STN" -o user_agent="$(shuf -n1 .ua)")
			_cfaccess
		}
# //heal - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		if [[ $HP1 -lt $HEAL ]] ; then
			echo "🆘 HP < $HPER%"
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$HL" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(lynx -cfg=~/twm/cfg1 -source "$URL$ACCESS" -useragent="$(shuf -n1 .ua)")
			_cfaccess
			HP1=$HPFULL
			ITVL=2.5
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
	w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/clanfight -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
#	lynx -cfg=~/twm/cfg1 $URL/clanfight -useragent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
	echo "Clan fight(✔)"
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)")
}
