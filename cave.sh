# /cave
function _cave () {
	_clanid
	if [[ -n $CLD ]]; then
		w3m -cookie "$URL/clan/$CLD/quest/take/5" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
		w3m -cookie "$URL/clan/$CLD/quest/help/5" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
	fi
	SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL/cave/" -o user_agent="$(shuf -n1 .ua)")
	_condition () {
		CGTHR=$(echo $SRC | sed 's/href=/\n/g' | grep -o '/cave/gather/')
		CSPDP=$(echo $SRC | sed 's/href=/\n/g' | grep -o '/cave/speedUp/')
		CDWN=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n1 | grep -o '/cave/down/')
		CTTCK=$(echo $SRC | sed 's/href=/\n/g' | grep -o '/cave/attack/')
	}
	_action () {
		AGTHR=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/gather/' | head -n1 | cut -d\' -f2)
		ASPDP=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/speedUp/' | head -n1 | cut -d\' -f2)
		ADWN=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/down/' | head -n1 | cut -d\' -f2)
		ATTCK=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/attack/' | head -n1 | cut -d\' -f2)
	}
	_condition
	_action
	num=0
	until [[ $num -eq 8 ]]; do
		if [[ -n CGTHR ]]; then
			SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$AGTHR" -o user_agent="$(shuf -n1 .ua)")
			_condition
			_action
		elif [[ -n CSPDP ]]; then
			SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$ASPDP" -o user_agent="$(shuf -n1 .ua)")
			_condition
			_action
		elif [[ -n CDWN ]]; then
			SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$ADWN" -o user_agent="$(shuf -n1 .ua)")
			_condition
			_action
			num=$[$num+1]
		elif [[ -n CTTCK ]]; then
			SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$ATTCK" -o user_agent="$(shuf -n1 .ua)")
			_condition
			_action
			SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL/cave/runaway" -o user_agent="$(shuf -n1 .ua)")
			_condition
			_action
			SRC=$(w3m -cookie -dump_source -o accept_encoding=='*;q=0' "$URL$ADWN" -o user_agent="$(shuf -n1 .ua)")
			_condition
			_action
			num=$[$num-1]
		fi
	done
	if [[ -n $CLD ]]; then
		w3m -cookie "$URL/clan/$CLD/quest/end/5" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
		w3m -cookie "$URL/clan/$CLD/quest/deleteHelp/5" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
	fi
	echo -e "cave (✔)\n"
}
