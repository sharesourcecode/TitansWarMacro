# /trade
function _trade () {
	echo "Checking for gold exchange..."
	SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/trade/exchange" -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| grep 'silver/1' | head -n1 | cut -d\= -f2 | cut -d\' -f1)
	EXIST=$(echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange' | grep 'silver/1' | head -n1 | cut -d\/ -f3)
	while [[ -n $EXIST ]]; do
		SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/trade/exchange/silver/1?r=$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| grep 'silver/1' | head -n1 | cut -d\= -f2 | cut -d\' -f1)
		EXIST=$(echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange' | grep 'silver/1' | head -n1 | cut -d\/ -f3)
		echo "$ACCESS"
	done
		echo -e "Exchange (✔)\n"
	if [[ -n $CLD ]] ; then
		CODE=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | cut -d\/ -f5 | tr -cd "[[:digit:]]")
		echo -e "/clan/$CLD/money/?r=$CODE&silver=1000&gold=2&confirm=true&type=limit"
		w3m -debug -dump "$URL/clan/$CLD/money/?r=$CODE&silver=1000&gold=1&confirm=true&type=limit" -o user_agent="$(shuf -n1 .ua)"
		CODE=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | cut -d\/ -f5 | tr -cd "[[:digit:]]")
		echo -e "/clan/$CLD/money/?r=$CODE&silver=1000&gold=1&confirm=true&type=limit"
		w3m -debug -dump "$URL/clan/$CLD/money/?r=$CODE&silver=1000&gold=1&confirm=true&type=limit" -o user_agent="$(shuf -n1 .ua)"
		echo -e "Clan Money (✔)\n"
	fi
}
