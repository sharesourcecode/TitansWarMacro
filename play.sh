_play () {
#	_coliseum #for test
	_msgs () {
		_proxy
		echo -e "Latest posts:" >msgs.txt
		w3m -debug $ENC $URL/ -o user_agent="$(shuf -n1 .ua)" | head -n3 | sed "/\[/d;/\|/d" >> msgs.txt
		w3m -debug $ENC $URL/mail -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 >> msgs.txt
		echo -e "\n" >> msgs.txt
	}
	_msgs
	_all () {
		_proxy
#		_AtakeHelp
		_arena
		_openChest
#		_AdeleteEnd
		_cave
		_campaign
		_career
		_clandungeon
		_trade
		_money
#		_built
	}
# /game time
	L=$(echo {0..3} | sed 's, ,\n,g' | shuf -n1)
	case $(date +%H:%M) in
# /Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
		(09:58|15:58|21:58)
			_proxy
#			_AtakeHelp
			_fullmana
#			_AdeleteEnd
			until [[ $(date +%M:%S) = 59:5* ]] ; do
				echo 'Valley of the Immortals will be started...'
				sleep 1
				[[ $(date +%M) > 00 ]] && break
			done
			SRC=$(w3m -debug -dump_source $ENC "$URL/undying/enterGame" -o user_agent="$(shuf -n1 .ua)")
			_undying
			_msgs
			_crono ;;
# /Battle of banners 10:15:00 - 16:15:00
#		(10:13|16:13)
#			_proxy
#			SRC=$(w3m -debug -dump_source $ENC "$URL/flagfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
#			until [[ $(date +%M:%S) = 14:5* ]] ; do
#				echo 'Battle of banners will be started...'
#				sleep 1
#				[[ $(date +%M) > 15 ]] && break
#			done
#			SRC=$(w3m -debug -dump_source $ENC "$URL/flagfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
#			_flagfight
#			_msgs
#			_crono ;;
# /Clan coliseum 10:30:00 - 15:00:00
#		(10:28|14:58)
#			_proxy
#			until [[ $(date +%M:%S) = *9:5* ]] ; do
#				echo 'Clan coliseum will be started...'
#				sleep 1
#				[[ $(date +%M) = 00 ]] && break
#			done
#			SRC=$(w3m -debug -dump_source $ENC "$URL/clancoliseum/?close=reward" -o user_agent="$(shuf -n1 .ua)")
#			SRC=$(w3m -debug -dump_source $ENC "$URL/clancoliseum/enterFight" -o user_agent="$(shuf -n1 .ua)")
#			_clancoliseum
#			_msgs
#			_crono ;;
# /Clan tournament 11:00:00 - 19:00:00
		(10:58|18:58)
			_proxy
			SRC=$(w3m -debug -dump_source $ENC "$URL/clanfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
			until [[ $(date +%M:%S) = 59:40 ]] ; do
				echo 'Clan tournament will be started...'
				sleep 1
				[[ $(date +%M) = 00 ]] && break
			done
			_clanfight
			_msgs
			_crono ;;
# /King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
		(12:28|16:28|22:28)
			_proxy
			until [[ $(date +%M:%S) = 29:5* ]] ; do
				echo 'King of the Immortals will be started...'
				sleep 1
				[[ $(date +%M) > 30 ]] && break
			done
			SRC=$(w3m -debug -dump_source $ENC "$URL/king/enterGame" -o user_agent="$(shuf -n1 .ua)")
			_king
			_arena
			_msgs
			_crono ;;
# /Ancient Altars 14:00:00 - 21:00:00
		(13:58|20:58)
			_proxy
			if [[ $(date +%H) = 13 ]] ; then
#				_AtakeHelp
				_fullmana
#				_AdeleteEnd
			fi
			until [[ $(date +%M:%S) = 59:5* ]] ; do
				echo 'Ancient Altars will be started...'
				sleep 1
				[[ $(date +%M) = 00 ]] && break
			done
			SRC=$(w3m -debug -dump_source $ENC "$URL/altars/enterFight" -o user_agent="$(shuf -n1 .ua)")
			_altars
			_msgs
			_crono ;;
		(0[02468]:[04]$L|0[13579]:2$L|1[048]:4$L|20:[04]$L|1[13579]:2$L|2[13]:2$L|1[28]:0$L)
			_proxy;
			_all ;
			_coliseum ;
			_msgs
			_crono ;;
		(*)
			_sleep ;
			_crono ;;
	esac
}
