#!/bin/bash
# //sources - - - - - - - - - - - - - - - - - - - -
cd ~/twn
. torstop.sh ; . requeriments.sh ; . loginlogoff.sh
. clanid.sh ; . crono.sh ; . arena.sh ; . coliseum.sh
. campaign.sh ; . play.sh
# //fuctions - - - - - - - - - - - - - - - - - - - -
rpt=0
_requeriments
ts=20
#_torstop
_loginlogoff
while true ; do
	rpt=$[$rpt+1]
	sleep 1
	if [[ $rpt -ne 1 ]] ; then
		ts=20
		#_torstop
	fi
	_play
done
exit
