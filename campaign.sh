# /campaign
_campaign () {
	SRC=$(w3m -debug -dump_source $ENC "$URL/campaign" -o user_agent="$(shuf -n1 .ua)")
	ENTER=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }' | awk -F\/ '{ print $3 }')
	ACCESS=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }')
	while [[ -n $ENTER && -n $ACCESS ]]; do
		SRC=$(w3m -debug -dump_source $ENC $URL$ACCESS -o user_agent="$(shuf -n1 .ua)")
		ENTER=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }' | awk -F\/ '{ print $3 }')
		ACCESS=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }')
		echo "$ACCESS"
	done
}
