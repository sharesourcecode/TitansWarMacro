# /campaign
_campaign () {
	SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/campaign" -o user_agent="$(shuf -n1 .ua)")
	ENTER=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1 | cut -d\/ -f3)
	ACCESS=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1)
	while [[ -n $ENTER && -n $ACCESS ]]; do
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL$ACCESS -o user_agent="$(shuf -n1 .ua)")
		ENTER=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1 | cut -d\/ -f3)
		ACCESS=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1)
		echo "$ACCESS"
	done
}
