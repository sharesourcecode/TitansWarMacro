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
}
