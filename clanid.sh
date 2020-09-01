# /clan id
_clanid () {
	SRC=$(w3m -debug -dump_source $ENC "$URL/clan" -o user_agent="$(shuf -n1 .ua)")
	CLD=$(echo $SRC | sed "s/\/clan\//\\n/g" | grep 'built\/' | cut -d\/ -f1)
}
