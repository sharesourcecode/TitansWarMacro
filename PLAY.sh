#!/bin/bash
# //sources - - - - - - - - - - - - - - - - - - - -
cd ~/twm
. torstop.sh ; . requeriments.sh ; . loginlogoff.sh
. clanid.sh ; . crono.sh ; . arena.sh ; . coliseum.sh
. campaign.sh ; . play.sh ; . altars.sh ; . clanfight.sh
. clancoliseum.sh ; . king.sh ; . undying.sh ; . clandungeon.sh
. trade.sh ; . career.sh
# //fuctions - - - - - - - - - - - - - - - - - - - -
rpt=0
_requeriments
#more ~/twm/LICENSE
ts=20
#_torstop
_loginlogoff
while true ; do
	rpt=$[$rpt+1]
	sleep 1
	if [[ $rpt -ne 1 ]] ; then
		ts=20
#		_torstop
	fi
	_play
done
kill -9 $$
exit
