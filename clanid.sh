# /clan id
_clanid () {
	SRC=$(w3m -debug -dump_source -o http_proxy="http://$proxy" $ENC "$URL/clan" -o user_agent="$(shuf -n1 .ua)")
	CLD=$(echo $SRC | sed "s/\/clan\//\\n/g" | grep 'built\/' | awk -F\/ '{ print $1 }')
}
