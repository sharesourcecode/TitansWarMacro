_play () {
	_mail () {
		USID=1597588
		SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/chat/titans/changeRoom/" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed "s/value\=/value\=\n/g" | grep '\<table' | cut -d\" -f2 | head -n1)
		SND1="Enviar"
#/
echo -e "r=$ACCESS&text="`cat << EOF
I'm use macro bot tinyurl.com/ta6wzxf
EOF`"&send_message=$SND1" >mail.txt
#\
		SRC=$(w3m -debug -post mail.txt -dump_source -o accept_encoding=='*;q=0' "$URL/mail/$USID" -o user_agent="$(shuf -n1 .ua)")
	}
	_all () {
		_AtakeHelp
		_arena
		_AdeleteEnd
		_cave
		_campaign
		_career
		_clandungeon
		_trade
#		[[ -n $mail ]] && _mail
#		_torstop
	}
# /game time
	L=$(echo {0..4} | sed 's, ,\n,g' | shuf -n1)
	case $(date +%H:%M) in
# /Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
		(09:58|15:58|21:58)
			_AtakeHelp
			_fullmana
			_AdeleteEnd
			until [[ $(date +%M:%S) = 59:5* ]] ; do
				echo 'Valley of the Immortals will be started...'
				sleep 1
			done
			SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/undying/enterGame" -o user_agent="$(shuf -n1 .ua)")
			_undying
			_crono ;;
# /Battle of banners 10:15:00 - 16:15:00
#		(10:14|16:14)
#			until [[ $(date +%M:%S) = 14:5* ]] ; do
#				echo 'Battle of banners will be started...'
#				sleep 1
#			done
#		SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/flagfight/enterFight -o user_agent="$(shuf -n1 .ua)")
#		_crono
# /Clan coliseum 10:30:00 - 15:00:00
		(10:29|14:59)
			until [[ $(date +%M:%S) = *9:5* ]] ; do
				echo 'Clan coliseum will be started...'
				sleep 1
			done
			SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/clancoliseum/?close=reward" -o user_agent="$(shuf -n1 .ua)")
			SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/clancoliseum/enterFight" -o user_agent="$(shuf -n1 .ua)")
			_clancoliseum
			_crono ;;
# /Clan tournament 11:00:00 - 19:00:00
		(10:59|18:59)
			until [[ $(date +%M:%S) = 59:[45]* ]] ; do
				echo 'Clan tournament will be started...'
				sleep 1
			done
			SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/clanfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
			_clanfight
			_crono ;;
# /King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
		(12:29|16:29|22:29)
			until [[ $(date +%M:%S) = 29:5* ]] ; do
				echo 'King of the Immortals will be started...'
				sleep 1
			done
			SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/king/enterGame" -o user_agent="$(shuf -n1 .ua)")
			_king
			_crono ;;
# /Ancient Altars 14:00:00 - 21:00:00
		(13:58|20:59)
			if [[ $(date +%H) = 13 ]] ; then
				_AtakeHelp
				_fullmana
				_AdeleteEnd
			fi
			until [[ $(date +%M:%S) = 59:5* ]] ; do
				echo 'Ancient Altars will be started...'
				sleep 1
			done
			SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/altars/enterFight" -o user_agent="$(shuf -n1 .ua)")
			_altars
			_crono ;;
		(0[02468]:[04]$L|0[13579]:2$L|1[048]:4$L|20:[04]$L|1[13579]:2$L|2[13]:2$L|1[28]:0$L)
			_all ;
			_coliseum ;
#			[[ $URL = 'furiadetitas.net' ]] && \
#			_online
			_crono ;;
		(*)
			echo 'No battles now, waiting +30s...' ;
			sleep 30 ;
			_crono ;;
	esac
}
