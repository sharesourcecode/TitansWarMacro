#!/bin/bash
OP=""
# /sources
cd ~/twm
. requeriments.sh ; . loginlogoff.sh
. flagfight.sh ; . clanid.sh ; . crono.sh ; . arena.sh ; . coliseum.sh
. campaign.sh ; . play.sh ; . altars.sh ; . clanfight.sh
. clancoliseum.sh ; . king.sh ; . undying.sh ; . clandungeon.sh
. trade.sh ; . career.sh ; . cave.sh
# /functions
_show () {
		HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
		HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep "hp" | head -n3 | tail -n1 | cut -d\< -f1 | cut -d\; -f2 | tr -cd "[[:digit:]]")
		[[ -n $HP1 && -n $HP2 ]] && echo -e "$URL\nYou: $HP1 - $HP2 :enemy\n"
		[[ -z $HP1 && -n $HP2 ]] && echo -e "$URL\nYou: 💀 - $HP2 :enemy\n"
	}
	_access () {
		ENTERFIGHT=$(echo $SRC | sed 's/href=/\n/g' | grep '/enterFight/' | head -n1 | cut -d\' -f2)
		ENTERGAME=$(echo $SRC | sed 's/href=/\n/g' | grep '/enterGame/' | head -n1 | cut -d\' -f2)
		ATK=$(echo $SRC | sed 's/href=/\n/g' | grep '/atk/' | head -n1 | cut -d\' -f2)
		ATTACK=$(echo $SRC | sed 's/href=/\n/g' | grep '/attack/' | head -n1 | cut -d\' -f2)
		ATKRND=$(echo $SRC | sed 's/href=/\n/g' | grep '/atkrnd/' | head -n1 | cut -d\' -f2)
		ATTACKRANDOM=$(echo $SRC | sed 's/href=/\n/g' | grep '/attackrandom/' | head -n1 | cut -d\' -f2)
		KINGATK=$(echo $SRC | sed 's/href=/\n/g' | grep 'king/kingatk/' | head -n1 | cut -d\' -f2)
		DODGE=$(echo $SRC | sed 's/href=/\n/g' | grep '/dodge/' | head -n1 | cut -d\' -f2)
		HEAL=$(echo $SRC | sed 's/href=/\n/g' | grep '/heal/' | head -n1 | cut -d\' -f2)
		STONE=$(echo $SRC | sed 's/href=/\n/g' | grep '/stone/' | head -n1 | cut -d\' -f2)
		GRASS=$(echo $SRC | sed 's/href=/\n/g' | grep '/grass/' | head -n1 | cut -d\' -f2)
		BEXIT=$(echo $SRC | grep -o 'user.png')
		OUTGATE=$(echo $SRC | grep -o 'out_gate')
		LEAVEFIGHT=$(echo $SRC | sed 's/href=/\n/g' | grep '/leaveFight/' | head -n1 | cut -d\' -f2)
		WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4) #white/dred
		PRTCT=$(echo $SRC | grep -io '<b>ueliton</b>')
		HLHP=$(expr $FULL \* $HPER \/ 100)
		_show
	}
rpt=0
_requeriments
ts=20
_loginlogoff
while true ; do
	rpt=$[$rpt+1]
	sleep 1
	if [[ $rpt -ne 1 ]] ; then
		ts=20
	fi
	_play
done
kill -9 $$
exit
