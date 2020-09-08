# /trade
_trade () {
	echo "Checking for gold exchange..."
	SRC=$(w3m -debug -dump_source $ENC "$URL/trade/exchange" -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| grep 'silver/1' | head -n1 | awk -F\= '{ print $2 }' | awk -F\' '{ print $1 }')
	EXIST=$(echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange' | grep 'silver/1' | head -n1 | awk -F\/ '{ print $3 }')
	while [[ -n $EXIST ]]; do
		SRC=$(w3m -debug -dump_source $ENC "$URL/trade/exchange/silver/1?r=$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| grep 'silver/1' | head -n1 | awk -F\= '{ print $2 }' | awk -F\' '{ print $1 }')
		EXIST=$(echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange' | grep 'silver/1' | head -n1 | awk -F\/ '{ print $3 }')
		echo -e "/trade/exchange/silver/1?r=$ACCESS"
	done
		echo -e "Exchange (✔)\n"
}
_money () {
	if [[ -n $CLD ]] ; then
		CODE=$(w3m -debug -dump_source $ENC $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]")
		echo -e "/clan/$CLD/money/?r=$CODE&silver=1000&gold=2&confirm=true&type=limit"
		w3m -debug -dump $ENC "$URL/clan/$CLD/money/?r=$CODE&silver=1000&gold=1&confirm=true&type=limit" -o user_agent="$(shuf -n1 .ua)"
		CODE=$(w3m -debug -dump_source $ENC $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]")
		echo -e "/clan/$CLD/money/?r=$CODE&silver=0&gold=1&confirm=true&type=limit"
		w3m -debug -dump $ENC "$URL/clan/$CLD/money/?r=$CODE&silver=1000&gold=1&confirm=true&type=limit" -o user_agent="$(shuf -n1 .ua)"
		echo -e "Clan Money (✔)\n"
	fi
}
_built () {
	if [[ -n $CLD ]] ; then
		CODE=$(w3m -debug -dump_source $ENC $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]")
		echo -e "/clan/$CLD/built/?goldUpgrade=true&r=$CODE"
		w3m -debug -dump $ENC "$URL/clan/$CLD/built/?goldUpgrade=true&r=$CODE" -o user_agent="$(shuf -n1 .ua)"
		CODE=$(w3m -debug -dump_source $ENC $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]")
		echo -e "/clan/$CLD/built/?silverUpgrade=true&r=$CODE"
		w3m -debug -dump $ENC "$URL/clan/$CLD/built/?silverUpgrade=true&r=$CODE" -o user_agent="$(shuf -n1 .ua)"
		echo -e "Clan Built upgrade (✔)\n"
	fi
}
