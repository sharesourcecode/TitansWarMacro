# /time
_crono () {
	HOUR=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL" -o user_agent="$(shuf -n1 .ua)" | sed 's/--/\n/g' | grep '/online/' | cut -d\: -f1 | tr -cd '[:digit:]')
#	HOUR=$(lynx -cfg=~/twm/cfg1 -source "$URL" -useragent="$(shuf -n1 .ua)" | sed 's/--/\n/g' | grep '/online/' | cut -d\: -f1 | tr -cd '[:digit:]')
	[[ $HOUR = 00 ]] && HOUR=0
	[[ $HOUR = 01 ]] && HOUR=1
	[[ $HOUR = 02 ]] && HOUR=2
	[[ $HOUR = 03 ]] && HOUR=3
	[[ $HOUR = 04 ]] && HOUR=4
	[[ $HOUR = 05 ]] && HOUR=5
	[[ $HOUR = 06 ]] && HOUR=6
	[[ $HOUR = 07 ]] && HOUR=7
	[[ $HOUR = 08 ]] && HOUR=8
	[[ $HOUR = 09 ]] && HOUR=9
#	MIN=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL" -o user_agent="$(shuf -n1 .ua)" | sed 's/--/\n/g' | grep '/online/' | cut -d\: -f2 | tr -cd '[:digit:]')
#	MIN=$(lynx -cfg=~/twm/cfg1 -source "$URL" -useragent="$(shuf -n1 .ua)" | sed 's/--/\n/g' | grep '/online/' | cut -d\: -f2 | tr -cd '[:digit:]')
	MIN=`date +%M`
	[[ $MIN = 00 ]] && MIN=0
	[[ $MIN = 01 ]] && MIN=1
	[[ $MIN = 02 ]] && MIN=2
	[[ $MIN = 03 ]] && MIN=3
	[[ $MIN = 04 ]] && MIN=4
	[[ $MIN = 05 ]] && MIN=5
	[[ $MIN = 06 ]] && MIN=6
	[[ $MIN = 07 ]] && MIN=7
	[[ $MIN = 08 ]] && MIN=8
	[[ $MIN = 09 ]] && MIN=9
	echo -e "\n $URL ⏰ $HOUR:$MIN\n"
}
_sleep () {
	SLEEP=849
	_crono
	[[ $MIN = 15 ]] && SLEEP=779
	[[ $MIN = 16 ]] && SLEEP=720
	[[ $MIN = 17 ]] && SLEEP=660
	[[ $MIN = 18 ]] && SLEEP=600
	[[ $MIN = 19 ]] && SLEEP=540
	[[ $MIN = 20 ]] && SLEEP=480
	[[ $MIN = 21 ]] && SLEEP=420
	[[ $MIN = 22 ]] && SLEEP=360
	[[ $MIN = 23 ]] && SLEEP=300
	[[ $MIN = 24 ]] && SLEEP=240
	[[ $MIN = 25 ]] && SLEEP=180
	[[ $MIN = 26 ]] && SLEEP=120
	[[ $MIN = 27 ]] && SLEEP=60
	[[ $MIN = 28 ]] && SLEEP=30
	[[ $MIN = 29 ]] && SLEEP=1

	[[ $MIN = 45 ]] && SLEEP=780
	[[ $MIN = 46 ]] && SLEEP=720
	[[ $MIN = 47 ]] && SLEEP=660
	[[ $MIN = 48 ]] && SLEEP=600
	[[ $MIN = 49 ]] && SLEEP=540
	[[ $MIN = 50 ]] && SLEEP=480
	[[ $MIN = 51 ]] && SLEEP=420
	[[ $MIN = 52 ]] && SLEEP=360
	[[ $MIN = 53 ]] && SLEEP=300
	[[ $MIN = 54 ]] && SLEEP=240
	[[ $MIN = 55 ]] && SLEEP=180
	[[ $MIN = 56 ]] && SLEEP=120
	[[ $MIN = 57 ]] && SLEEP=60
	[[ $MIN = 58 ]] && SLEEP=30
	[[ $MIN = 59 ]] && SLEEP=1
	sleep $SLEEP
}
