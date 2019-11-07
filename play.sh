_play () {
# //game time
	_crono
	if [[ $HOUR -le 8 || $HOUR -eq 9 && $MIN -le 55 || $HOUR -eq 23 ]] ; then
		_arena
#		_career
#		_clandungeon
#		_campaign
#		_trade
		_coliseum
		ts=2400
		_torstop
		_crono
# //Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
	elif [[ $HOUR -eq 9 && $MIN -gt 55 || $HOUR -eq 15 && $MIN -gt 55 || $HOUR -eq 21 && $MIN -gt 55 ]] ; then
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/undying/enterGame -o user_agent="$(shuf -n1 .ua)")
		_crono
# //Battle of banners 10:15:00 - 16:15:00
	elif [[ $HOUR -eq 10 && $MIN -gt 10 && $MIN -lt 16 || $HOUR -eq 16 && $MIN -gt 10 && $MIN -lt 16 ]] ; then
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URLhttp/flagfight/enterFight -o user_agent="$(shuf -n1 .ua)")
		_crono
# //Clan coliseum 10:30:00 - 15:00:00
	elif [[ $HOUR -eq 10 && $MIN -gt 25 && $MIN -lt 31 || $HOUR -eq 14 && $MIN -gt 55 ]] ; then
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/clancoliseum/enterFight -o user_agent="$(shuf -n1 .ua)")
		_crono
# //Clan tournament 11:00:00 - 19:00:00
	elif [[ $HOUR -eq 10 && $MIN -gt 55 || $HOUR -eq 18 && $MIN -gt 55 ]] ; then
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/clanfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
		_crono
# //King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
	elif [[ $HOUR -eq 12 && $MIN -gt 25 && $MIN -lt 31 || $HOUR -eq 16 && $MIN -gt 25 && $MIN -lt 31 || $HOUR -eq 22 && $MIN -gt 25 && $MIN -lt 31 ]] ; then
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/king/enterGame -o user_agent="$(shuf -n1 .ua)")
		_crono
# //Ancient Altars 14:00:00 - 21:00:00
	elif [[ $HOUR -eq 13 && $MIN -gt 55 || $HOUR -eq 20 && $MIN -gt 55 ]] ; then
		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URL/altars/enterFight -o user_agent="$(shuf -n1 .ua)")
		_crono
	else
		_arena
#		_career
#		_clandungeon
#		_trade
#		_campaign
		_coliseum
		ts=1200
		_torstop
		_crono
	fi
}
