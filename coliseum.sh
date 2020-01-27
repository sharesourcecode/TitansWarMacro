_coliseum () {
# /enterFight
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
	HPER='41'
	RPER='9'
	ITVL='1'
	echo -e "\nColiseum"
	echo $URL
	w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/coliseum/?end_fight=true -o user_agent="$(shuf -n1 .ua)" | head -n11 | tail -n7 | sed "/\[2hit/d;/\[str/d;/combat/d"
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/coliseum -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/enterFight/' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' ""$URL$ACCESS"?end_fight=true" -o user_agent="$(shuf -n1 .ua)")
# /wait
	echo " 😴 Waiting..."
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | cut -d\' -f2)
        EXIT=$(echo $SRC | grep -o '/leaveFight/' | head -n1)
	START=`date +%M`
	while [[ -n $EXIT ]] ; do
                END=$(expr `date +%M` \- $START)
                [[ $END -gt 6 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/coliseum -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | grep -o '/leaveFight/' | head -n1)
	done
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
	_access
	START=`date +%M`
	until [[ -z $OUTGATE && -z $ATK ]] ; do
# /function random
                END=$(expr `date +%M` \- $START)
                [[ $END -gt 6 ]] && break
		_random () {
			echo '🔁'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ATKRND" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
		}
# /function dodge
		_dodge () {
			echo '🛡️'
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
		}
# /heal
#	    if [[ $WDRED == dred && $HP1 -lt $HLHP ]] ; then
		if [[ $HP1 -lt $HLHP ]] ; then
			echo "🆘 HP < $HPER%"
			SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)")
			_access
			HP1=$HPFULL
			ITVL='2.5'
			sleep $ITVL
			_dodge
			_random
# /random
		elif [[ -n $PRTCT || $WDRED == white && `expr $HP1 + $HP1 \* $RPER \/ 100` -lt $HP2 ]] ; then
			_random
			_dodge
# /dodge
		else
			_dodge
		fi
	done
# /view
	echo ""
	w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/coliseum -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
	echo "Coliseum (✔)"
	sleep 60
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)")
}

