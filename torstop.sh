# /start tor/kill script
_torstop () {
	pkill -9 tor
	if [[ $ts -le 30 ]] ; then
		ALERT="Starting Tor VPN, wait to"
		tor &
	else
		ALERT="Wait to"
	fi
        until [[ $ts -le 1 ]] ; do
		clear
		echo -e "\n$ALERT ("$ts"s)...\nOr press ENTER for stop.\n"
                ts=$[$ts-1]; read -t1 && kill -9 $$
        done
	reset
}
