_requeriments () {
# /tmp dir
	mkdir -p $HOME/.tmp
	cd $HOME/twm
# /update script and dependencies
	echo -e "\n Upgrading..."
	echo -e "👉 Please wait...☕👴"
	_sync () {
		curl https://github.com/sharesourcecode/twm/raw/master/cave.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 1/19"
		curl https://github.com/sharesourcecode/twm/raw/master/PLAY.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 2/19"
		curl https://github.com/sharesourcecode/twm/raw/master/altars.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 3/19"
		curl https://github.com/sharesourcecode/twm/raw/master/arena.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 4/19"
		curl https://github.com/sharesourcecode/twm/raw/master/campaign.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 5/19"
		curl https://github.com/sharesourcecode/twm/raw/master/career.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 6/19"
		curl https://github.com/sharesourcecode/twm/raw/master/clancoliseum.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 7/19"
		curl https://github.com/sharesourcecode/twm/raw/master/clandungeon.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 8/19"
		curl https://github.com/sharesourcecode/twm/raw/master/clanfight.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 9/19"
		curl https://github.com/sharesourcecode/twm/raw/master/clanid.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 10/19"
		curl https://github.com/sharesourcecode/twm/raw/master/coliseum.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 11/19"
		curl https://github.com/sharesourcecode/twm/raw/master/crono.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 12/19"
		curl https://github.com/sharesourcecode/twm/raw/master/king.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 13/19"
		curl https://github.com/sharesourcecode/twm/raw/master/loginlogoff.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 14/19"
		curl https://github.com/sharesourcecode/twm/raw/master/play.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 15/19"
		curl https://github.com/sharesourcecode/twm/raw/master/requeriments.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 16/19"
		curl https://github.com/sharesourcecode/twm/raw/master/trade.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 17/19"
		curl https://github.com/sharesourcecode/twm/raw/master/undying.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 18/19"
		curl https://github.com/sharesourcecode/twm/raw/master/flagfight.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 19/19"
		dos2unix *.sh &> /dev/null
	}
# /termux on android
	termux-wake-lock &> /dev/null
	if [[ $? = 0 ]] ; then
		[[ ! -e executed.txt ]] && pkg install termux-api w3m curl -y && >executed.txt
		[[ $(date +%H) -lt 10 || $(date +%H) -gt 22 ]] && _sync
		reset; clear
		echo -e "Successful updates!\n"
	else
		sudo apt install w3m curl -y
		[[ $(date +%H) -lt 10 || $(date +%H) -gt 22 ]] && _sync
		reset; clear
	fi
	cd $HOME/twm
# /user agents to $HOME/.tmp/.ua
	echo -e '"Opera/9.80 (J2ME/MIDP; Opera Mini/5.1.21214/28.2725; U; ru) Presto/2.8.119 Version/11.10"\n"Mozilla/5.0 (BB10; Kbd) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.3.2205 Mobile Safari/537.35+"' >.ua
	dos2unix ~/twm/.ua &> /dev/null
	cp ~/twm/.ua ~/.tmp/.ua &> /dev/null
# /servers
	if [[ -z $URL ]] ; then
		echo -e " 1) 🇬🇧 English, Global: Titan's War online\n 2) 🇷🇺 Русский: Битва Титанов онлайн\n 3) 🇵🇱 Polski: Wojna Tytanów online\n 4) 🇩🇪 Deutsch: Krieg der Titanen online\n 5) 🇪🇸 Español: Guerra de Titanes online\n 6) 🇧🇷 Brazil, 🇵🇹 Português: Furia de Titãs online\n 7) 🇮🇹 Italiano: Guerra di Titani online\n 8) 🇫🇷 Français: Combat des Titans online\n 9) 🇷🇴 Română: Războiul Titanilor online\n10) 🇨🇳 中文, Chinese: 泰坦之战\n11) 🇮🇩 Indonesian: Titan's War Indonesia\n0) ❌ Cancel\n"
		read -p "Select number Server[1 to 11]: " -t 300 -e -n 2 OP
		case $OP in
			(1) URL='tiwar.net' ; export TZ=Europe/London ;;

			(2|ru) URL='tiwar.ru' ; export TZ=Europe/Moscow ;;

			(3|pl) URL='tiwar.pl' ; export TZ=Europe/Warsaw ;;

			(4) URL='titanen.mobi' ; export TZ=Europe/Berlin ;;

			(5) URL='guerradetitanes.net' ; export TZ=America/Cancun ;;

			(6|fu) URL='furiadetitas.net' ; export TZ=America/Bahia ;;

			(7) URL='guerradititani.net' ; export TZ=Europe/Rome ;;

			(8|fr) URL='tiwar.fr' ; export TZ=Europe/Paris ;;

			(9|ro) URL='tiwar.ro' ; export TZ=Europe/Bucharest ;;

			(10|cn) URL='cn.tiwar.net' ; export TZ=Asia/Shanghai ;;

			(11|ba) URL='bahasa.tiwar.net' ; export TZ=Asia/Barnaul ;;

			(0) kill -9 $$ ;;

			(*) clear; [[ -n $OP ]] && echo -e "\n Invalid option: $(echo $OP)" && kill -9 $$ || echo -e "\n Time exceeded!" ;;
		esac
	fi
	clear
	[[ -z $URL ]] && exit
}
