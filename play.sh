_play () {
	_all () {
#		ts=60
		_arena
		_campaign
		_coliseum
#		_career
#		_clandungeon
#		_trade
#		_torstop
		}
	_crono
# //game time
	if [[ $HOUR -eq 0 || $HOUR -eq 1 || $HOUR -eq 2 || $HOUR -eq 3 || $HOUR -eq 4 || $HOUR -eq 5 || $HOUR -eq 6 || $HOUR -eq 7 || $HOUR -eq 8 || $HOUR -eq 23 ]] ; then
		_all
		sleep 987
		_crono
# //Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
	elif [[ $HOUR -eq 9 && $MIN -gt 45 || $HOUR -eq 15 && $MIN -gt 50 || $HOUR -eq 21 && $MIN -gt 50 ]] ; then
		_undying
		_crono
# //Battle of banners 10:15:00 - 16:15:00
#	elif [[ $HOUR -eq 10 && $MIN -gt 10 && $MIN -lt 16 || $HOUR -eq 16 && $MIN -gt 10 && $MIN -lt 16 ]] ; then
#		ts=300
#		SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' $URLhttp/flagfight/enterFight -o user_agent="$(shuf -n1 .ua)")
#		_crono
# //Clan coliseum 10:30:00 - 15:00:00
	elif [[ $HOUR -eq 10 && $MIN -gt 20 && $MIN -lt 31 || $HOUR -eq 14 && $MIN -gt 50 ]] ; then
#		ts=300
		_clancoliseum
		_crono
# //Clan tournament 11:00:00 - 19:00:00
	elif [[ $HOUR -eq 10 && $MIN -gt 50 || $HOUR -eq 18 && $MIN -gt 50 ]] ; then
#		ts=900
		_clanfight
		_crono
# //King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
	elif [[ $HOUR -eq 12 && $MIN -gt 20 && $MIN -lt 31 || $HOUR -eq 16 && $MIN -gt 20 && $MIN -lt 31 || $HOUR -eq 22 && $MIN -gt 20 && $MIN -lt 31 ]] ; then
#		ts=300
		_king
		_crono
# //Ancient Altars 14:00:00 - 21:00:00
	elif [[ $HOUR -eq 13 && $MIN -gt 50 || $HOUR -eq 20 && $MIN -gt 50 ]] ; then
#		ts=900
		_altars
		_crono
	else
		_all
		sleep 240
		_crono
	fi
}
