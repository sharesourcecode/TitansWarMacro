# /cave
function _cave () {
	_clanid
#	if [[ -n $CLD ]]; then
#		w3m -debug $ENC "$URL/clan/$CLD/quest/take/5" -o user_agent="$(shuf -n1 .ua)" | head -n15
#		w3m -debug $ENC "$URL/clan/$CLD/quest/help/5" -o user_agent="$(shuf -n1 .ua)" | head -n15
#	fi
	_condition () {
		SRC=$(w3m -debug -dump_source $ENC "$URL/cave/" -o user_agent="$(shuf -n1 .ua)")
		ACCESS1=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n1 | cut -d\' -f2)
		DOWN=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/down' | cut -d\' -f2)
		ACCESS2=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | cut -d\' -f2)
		ACTION=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | cut -d\' -f2 | tr -cd "[[:alpha:]]")
		MEGA=$(echo $SRC | sed 's/src=/\n/g' | grep '/images/icon/silver.png' | grep "'s'" | tail -n1 | grep -o 'M')
	}
	_condition
	num=2
	until [[ $num -eq 0 ]]; do
		_condition
		case $ACTION in
			(cavechancercavegatherrcavedownr)
				SRC=$(w3m -debug -dump_source $ENC "$URL$ACCESS2" -o user_agent="$(shuf -n1 .ua)") ;
				num=$[$num-1] ;
				echo $num ;;
			(cavespeedUpr)
#				SRC=$(w3m -debug -dump_source $ENC "$URL$ACCESS2" -o user_agent="$(shuf -n1 .ua)") ;
				num=$[$num-1] ;
				echo $num ;;
			(cavedownr|cavedownrclanbuiltprivateUpgradetruerrefcave)
				num=$[$num-1] ;
				SRC=$(w3m -debug -dump_source $ENC "$URL$DOWN" -o user_agent="$(shuf -n1 .ua)") ;
				echo $num ;;
			(caveattackrcaverunawayr)
				num=$[$num-1] ;
				SRC=$(w3m -debug -dump_source $ENC "$URL$ACCESS1" -o user_agent="$(shuf -n1 .ua)") ;
				SRC=$(w3m -debug -dump_source $ENC "$URL/cave/runaway" -o user_agent="$(shuf -n1 .ua)") ;
				echo $num ;;
			(*) num=0 ;;
		esac
		echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | cut -d\' -f2
	done
#	if [[ -n $CLD ]]; then
#		w3m -debug $ENC "$URL/clan/$CLD/quest/end/5" -o user_agent="$(shuf -n1 .ua)" | head -n15
#		w3m -debug $ENC "$URL/clan/$CLD/quest/deleteHelp/5" -o user_agent="$(shuf -n1 .ua)" | head -n15
#	fi
	echo -e "cave (✔)\n"
}
