_alliesID () {
# Friends ID
	SRC=$(w3m -debug -dump_source $ENC "$URL/mail/friends" -o user_agent="$(shuf -n1 .ua)")
	NPG=$(echo $SRC | sed 's/href=/\n/g' | grep "/mail/friends/[0-9]'>&#62;&#62;" | cut -d\' -f2 | cut -d\/ -f4)
	>tmp.txt; echo -ne "\033[33m"
	for num in `seq $NPG -1 1`; do w3m -debug \
	-dump_source $ENC \
	"$URL/mail/friends/$num" -o user_agent="$(shuf -n1 .ua)" | \
	grep -E -o "[0-9]{1,8}/'>[A-Z][a-z]{0,14}[\ ]{0,1}[A-Z]{0,1}[a-z]{0,12}</a>," | \
	grep -v "^$" >>tmp.txt; echo "Looking for allies on friend list page $num..."; \
	done
	sort -u tmp.txt -o tmp.txt
# Clan ID by Leader/Deputy on friend list
	ts=0
	>callies.txt; echo -ne "\033[36m"
	cat tmp.txt | awk -F/ '{ print $1 }' >ids.txt
	echo "Clan allies by Leader/Deputy on friends list..."
	while read IDN; do
		if [[ -n $IDN ]]; then
			SRC=$(w3m $ENC -dump_source $URL/user/$IDN)
			LEADER=$(echo $SRC | grep -E -o "[A-Za-z\ ]{2,20}</a>, <span class='green'>[A-Z]|[A-Za-z\ ]{2,20}</a>, <span class='blue'>[A-Z]" | cut -d\< -f1)
			alCLAN=$(echo $SRC | grep -E -o '/clan/[[:digit:]]{1,3}' | tail -n1)
			if [[ -n $LEADER ]] ; then
				ts=$[$ts+1]
				echo $LEADER >>callies.txt
				echo "$ts. Ally $LEADER $alCLAN added."
				sort -u callies.txt -o callies.txt
			fi
		fi
	done < ids.txt
# Print info
	grep -E -o "[A-Z][a-z]{0,14}[\ ]{0,1}[A-Z]{0,1}[a-z\]{0,12}" tmp.txt >allies.txt
	echo -ne "\033[33m"; echo "Allies for Coliseum and King of the Immortals:"
	cat allies.txt
	echo -ne "\033[37m"
	echo "Look UP↑ or ENTER to continue."
	read
}
