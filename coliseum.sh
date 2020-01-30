_coliseum () {
# /enterFight
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
	HPER='48'
	RPER='10'
	ITVL='1.7'
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
                [[ $END -gt 7 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/coliseum -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | grep -o '/leaveFight/' | head -n1)
	done
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
# /atk
		echo '🎯' && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ATK" -o user_agent="$(shuf -n1 .ua)")
		_access
# /heal
		[[ $HP1 -le $HLHP ]] && ITVL='2.6' && echo "🆘 HP < $HPER%" && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)") && \
		_access
# /dodge
		[[ $HP3 -ne $HP1 ]] && echo '🛡️' && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)") && \
		HP3=$HP1 && _access
# /random
		[[ $WDRED == white && `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 ]] && sleep $ITVL && echo '🔁' && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ATKRND" -o user_agent="$(shuf -n1 .ua)") && \
		_access
		sleep $ITVL
	done
# /view
	echo ""
	w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/coliseum -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d"
	echo "Coliseum (✔)"
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)")
}

