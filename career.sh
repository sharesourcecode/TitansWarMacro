# //career- - - - - - - - - - - - - - - - - - - - - - - - - -
# // /career/attack/?r=8781779
_career () {
	echo "Checking career..."
	SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/career" -o user_agent="$(shuf -n1 .ua)")
	ENTER=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | cut -d\' -f2)
	until [[ -z $ENTER ]]; do
		SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ENTER=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | cut -d\' -f2)
		echo " ⚔ $ACCESS"
	done
	echo -e "career (✔)\n"
}
