_altars () {
# /enterFight
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
	HPER='48'
	RPER='9'
	ITVL='1.7'
	echo -e "\nAltars"
	echo $URL
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/altars/enterFight -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'altars/enterFight' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'altars/attack/')
	START=`date +%M`
	while [[ -z $EXIT ]] ; do
                END=$(expr `date +%M` \- $START)
                [[ $END -gt 6 ]] && break
		echo -e "$URL\n 💤	...\n$ACCESS"
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/altars/?close=reward -o user_agent="$(shuf -n1 .ua)")
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/altars/enterFight -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/altars/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'altars/attack/')
	done
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	START=`date +%M`
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
		END=$(expr `date +%M` \- $START)
		[[ $END -gt 10 ]] && break
# /attack
		echo '🎯' && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ATTACK" -o user_agent="$(shuf -n1 .ua)")
		_access
# /heal
		[[ $HP1 -le $HLHP ]] && ITVL='2.6' && echo "🆘 HP < $HPER%" && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)") && \
		_access && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)") && \
		_access && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$STONE" -o user_agent="$(shuf -n1 .ua)") && \
		_access
# /dodge
		[[ $HP3 -ne $HP1 ]] && echo '🛡️' && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)") && \
		_access && HP3=$HP1 && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)") && \
		_access
# /random
		[[ $WDRED == white && `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 ]] && sleep $ITVL && echo '🔁' && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ATTACKRANDOM" -o user_agent="$(shuf -n1 .ua)") && \
		_access && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$STONE" -o user_agent="$(shuf -n1 .ua)") && \
		_access
		sleep $ITVL
	done
# /view
	w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/altars -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d"
	echo "Altars (✔)"
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)")
	sleep 120
}
