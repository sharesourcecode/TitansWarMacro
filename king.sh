_king () {
# /enterFight
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/1 -o user_agent="$(shuf -n1 .ua)")
	HPER='49'
	RPER='1'
	ITVL='1.8'
	echo -e "\nKing"
	echo $URL
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/king/enterGame -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | grep -o 'king/kingatk/')
	START=`date +%M`
	while [[ -z $EXIT ]] ; do
		END=$(expr `date +%M` \- $START)
		[[ $END -gt 6 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | grep -o 'king/kingatk/')
	done
# /game
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep "hp" | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd "[[:digit:]]")
	_access
	HP3=$HP1
	START=`date +%M`
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
		END=$(expr `date +%M` \- $START)
		[[ $END -gt 11 ]] && break
# /dodge
		[[ $HP3 -ne $HP1 ]] && HP3=$HP1 && echo '🛡️' && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)") && \
		_access
# /kingatk
		[[ -n $KINGATK ]] && echo '👑' && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$KINGATK" -o user_agent="$(shuf -n1 .ua)") && \
		_access
# /attack
		[[ -z $KINGATK ]] && echo '🎯' && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ATTACK" -o user_agent="$(shuf -n1 .ua)")
		_access
# /heal
		[[ $HP1 -le $HLHP ]] && ITVL='2.6' && echo "🆘 HP < $HPER%" && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)") && \
		_access
# /grass
		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 || `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP3 ]] && echo '🙌' && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)") && \
		_access
# /stone
		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 || $HP2 -le 15 ]] && echo '💪' && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$STONE" -o user_agent="$(shuf -n1 .ua)") && \
		_access
# /random
		[[ $WDRED == white && `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 ]] && echo '🔁' && \
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ATTACKRANDOM" -o user_agent="$(shuf -n1 .ua)") && \
		_access
		sleep $ITVL
	done
# /view
	echo ""
	w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/king -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d"
	echo "King (✔)"
	SRC=$(w3m -cookie -debug -o accept_encoding=='*;q=0' $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)")
	sleep 30
	_coliseum
}


