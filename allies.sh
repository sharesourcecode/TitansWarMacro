# Friends ID
_alliesID () {
	SRC=$(w3m -debug -dump_source $ENC "$URL/mail/friends" -o user_agent="$(shuf -n1 .ua)")
	NPG=$(echo $SRC | sed 's/href=/\n/g' | grep "/mail/friends/[0-9]'>&#62;&#62;" | cut -d\' -f2 | cut -d\/ -f4)
	>allies.txt; echo -ne "\033[33m"
	for num in `seq $NPG -1 1`; do w3m -debug -dump_source $ENC "$URL/mail/friends/$num" -o user_agent="$(shuf -n1 .ua)" | sed "s/\/user\//\n\/user\//g" | cut -d\/ -f3 | sed "/W/d;/m/d;/s/d;/o/d;/\}/d;/\-/d;/>/d" | grep -v "^$" >>allies.txt; echo "Looking for allies on page $num of the friends list..."; done
	sort -u allies.txt -o allies.txt
# Clan ID by Leader/Deputy on friend list
	ts=0
	>callies.txt; echo -ne "\033[36m"
	echo "Looking Clan allies by Leaders/Deputy on friends list..."
	while read IDN; do
		if [[ -n $IDN ]]; then
			SRC=$(w3m -debug $ENC -dump_source "$URL/user/$IDN")
			LEADER=$(echo $SRC | grep -E -o "[A-Za-z\ ]{2,20}</a>, <span class='green'>[A-Z]|[A-Za-z\ ]{2,20}</a>, <span class='blue'>[A-Z]" | cut -d\< -f1)
			alCLAN=$(echo $SRC | grep -E -o '/clan/[[:digit:]]{1,3}' | tail -n1)
			if [[ -n $LEADER ]] ; then
				ts=$[$ts+1]
				echo $alCLAN >>callies.txt
				echo "$ts. Ally $LEADER $alCLAN added."
				sort -u callies.txt -o callies.txt
			fi
		fi
	done < allies.txt
	echo -ne "\033[37m"
}
