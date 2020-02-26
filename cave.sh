# /cave
function _cave () {
	_clanid
	w3m -cookie "$URL/clan/$CLD/quest/take/5" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
	w3m -cookie "$URL/clan/$CLD/quest/help/5" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
	_condition () {
		SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL/cave/" -o user_agent="$(shuf -n1 .ua)")
		ACCESS1=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n1 | cut -d\' -f2)
		DOWN=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/down' | cut -d\' -f2)
		ACCESS2=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | cut -d\' -f2)
		ACTION=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | cut -d\' -f2 | tr -cd "[[:alpha:]]")
		MEGA=$(echo $SRC | sed 's/src=/\n/g' | grep '/images/icon/silver.png' | grep "'s'" | tail -n1 | grep -o 'M')
	}
	_condition
	num=9
	until [[ $num -eq 0 ]]; do
		_condition
		case $ACTION in
			(cavechancercavegatherrcavedownr|cavespeedUpr)
				[[ -z $MEGA ]] && num=0
				SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS2" -o user_agent="$(shuf -n1 .ua)") ;;
			(cavedownr|cavedownrclanbuiltprivateUpgradetruerrefcave)
				num=$[$num-1] ;
				SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$DOWN" -o user_agent="$(shuf -n1 .ua)") ;
				echo $num ;;
			(caveattackrcaverunawayr)
				num=$[$num-1] ;
				SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS1" -o user_agent="$(shuf -n1 .ua)") ;
				SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL/cave/runaway" -o user_agent="$(shuf -n1 .ua)") ;
				echo $num ;;
		esac
		echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | cut -d\' -f2
	done
	if [[ -n $CLD ]]; then
		w3m -cookie "$URL/clan/$CLD/quest/end/5" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
		w3m -cookie "$URL/clan/$CLD/quest/deleteHelp/5" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
	fi
	echo -e "cave (✔)\n"
}
