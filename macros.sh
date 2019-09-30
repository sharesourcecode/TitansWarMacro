#!/bin/bash
# //https://raw.githubusercontent.com/AlvesUeliton/Titans-War-Macros/master/macros.sh
# MIT License
#
# Copyright (c) 2019 Ueliton Alves Dos Santos
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
clear
# //kill - - - - - - - - - - - - - - - - - - - - - - - - - - -
function _stop () {
	echo -e "\n[Press ENTER for stop or wait to continue...]"
	read -t10
		[[ $? = 0 ]] && kill -9 $$
	reset
}
# //servers - - - - - - - - - - - - - - - - - - - - - - - - -
SERVERS=("English, Global: Titan's War online" "Русский: Битва Титанов онлайн" "Polski: Wojna Tytanów online" "Deutsch: Krieg der Titanen online" "Español: Guerra de Titanes online" "Brazil, Português: Furia de Titãs online" "Italiano: Guerra di Titani online" "Français: Combat des Titans online" "Română: Războiul Titanilor online" "Srpski: Rat Titana online" "中文, Chinese: 泰坦之战" "Indonesian: Titan's War Indonesia" "India, English: Titan's War India" "Cancel")
PS3="Select number Server: "

select action in "${SERVERS[@]}"
	do
		case $action in
			"English, Global: Titan's War online") URL="http://tiwar.net"
			break ;;

			"Русский: Битва Титанов онлайн") URL='http://tiwar.ru'
			break ;;

			"Polski: Wojna Tytanów online") URL='http://tiwar.pl'
			break ;;

			"Deutsch: Krieg der Titanen online") URL='http://titanen.mobi'
			break ;;

			"Español: Guerra de Titanes online") URL='http://guerradetitanes.net'
			break ;;

			"Brazil, Português: Furia de Titãs online") URL='http://furiadetitas.net'
			break ;;

			"Italiano: Guerra di Titani online") URL='http://guerradititani.net'
			break ;;

			"Français: Combat des Titans online") URL='http://tiwar.fr'
			break ;;

			"Română: Războiul Titanilor online") URL='http://tiwar.ro'
			break ;;

			"Srpski: Rat Titana online") URL='http://tiwar.rs'
			break ;;

			"中文, Chinese: 泰坦之战") URL='http://cn.tiwar.net'
			break ;;

			"Indonesian: Titan's War Indonesia") URL="http://bahasa.tiwar.net"
			break ;;

			"India, English: Titan's War India") URL="http://tiwar.in"
			break ;;

		        "Cancel") kill -9 $$
			break ;;
		    esac
done
clear
echo -e "Starting..."
# //tmp dir - - - - - - - - - - - - - - - - - - - - - - - - -
mkdir -p $HOME/.tmp
cd $HOME/.tmp
# //termux on android - - - - - - - - - - - - - - - - - - - -
termux-wake-lock &> /dev/null
# //user agents to $HOME/.tmp/.ua - - - - - - - - - - - - - -
echo -e '"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/600.7.12 (KHTML, like Gecko) Version/8.0.7 Safari/600.7.12"\n"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/600.8.9 (KHTML, like Gecko) Version/8.0.8 Safari/600.8.9"\n"Mozilla/5.0 (iPhone; CPU iPhone OS 8_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) CriOS/44.0.2403.67 Mobile/12D508 Safari/600.1.4"\n"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.1; rv:38.0) Gecko/20100101 Firefox/38.0"\n"Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36"\n"Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.10240"\n"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.65 Safari/537.36"\n"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/42.0 Safari/537.31"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0"\n"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.59.10 (KHTML, like Gecko) Version/5.1.9 Safari/534.59.10"\n"Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)"\n"Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)"\n"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) coc_coc_browser/50.0.125 Chrome/44.0.2403.125 Safari/537.36"\n"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)"\n"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0"\n"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36 Edge/12.0"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0"\n"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; GTB7.5; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C)"\n"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.10240"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0) LinkCheck by Siteimprove.com"\n"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.65 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.3; Win64; x64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4"\n"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0"\n"Mozilla/5.0 (Windows NT 6.2; WOW64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.2.2339 Mobile Safari/537.35+"\n"Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.65 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:40.0) Gecko/20100101 Firefox/40.0"\n"Mozilla/5.0 (Mobile; Windows Phone 8.1; Android 4.0; ARM; Trident/7.0; Touch; rv:11.0; IEMobile/11.0; NOKIA; Lumia 525) like iPhone OS 7_0_3 Mac OS X AppleWebKit/537 (KHTML, like Gecko) Mobile Safari/537"\n"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:37.0) Gecko/20100101 Firefox/37.0"\n"Mozilla/5.0 (Windows NT 5.1; WOW64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/44.0.2403.89 Chrome/44.0.2403.89 Safari/537.36"\n"Mozilla/5.0 (iPad; CPU OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/600.1.25 (KHTML, like Gecko) QuickLook/5.0"\n"Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:40.0) Gecko/20100101 Firefox/40.0"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; MATBJS; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (Windows NT 10.0; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"\n"Mozilla/5.0 (Windows NT 6.0; WOW64; rv:35.0) Gecko/20100101 Firefox/35.0"\n"Mozilla/5.0 (Linux; U; Android 4.3; en-us; ZTE-Z667G Build/JLS36C) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"\n"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; Touch; ASU2JS; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0"\n"Mozilla/5.0 (Windows NT 6.0; WOW64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 5.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.65 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.65 Safari/537.36"\n"Mozilla/5.0 (iPad; CPU OS 8_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12F69 Safari/600.1.4"\n"Mozilla/5.0 (Windows NT 6.0; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0"\n"Mozilla/5.0 (iPhone; CPU iPhone OS 8_4_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H321 Safari/600.1.4"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; TNJB; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0"\n"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; InfoPath.2)"\n"Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (iPad; CPU OS 7_1_2 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D257 Safari/9537.53"\n"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (iPhone; CPU iPhone OS 8_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12F70 Safari/600.1.4"\n"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) coc_coc_browser/50.2.155 Chrome/44.2.2403.155 Safari/537.36"\n"Mozilla/5.0 (X11; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0"\n"Mozilla/5.0 (iPad; CPU OS 8_4_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H321 Safari/600.1.4"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:35.0) Gecko/20100101 Firefox/35.0"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.78.2 (KHTML, like Gecko) Version/6.1.6 Safari/537.78.2"\n"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36"\n"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0"\n"Mozilla/5.0 (Mobile; rv:32.0) Gecko/32.0 Firefox/32.0"\n"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.2; WOW64; Trident/7.0; .NET4.0E; .NET4.0C; .NET CLR 3.5.30729; .NET CLR 2.0.50727; .NET CLR 3.0.30729; Tablet PC 2.0; McAfee; AmericasCardroom; BRI/2; GWX:DOWNLOADED)"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/7.0)"\n"Mozilla/5.0 (iPad; CPU OS 8_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12D508 Safari/600.1.4"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2483.0 Safari/537.36"\n"Mozilla/5.0 (Windows NT 5.1; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0"\n"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/6.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET4.0C; .NET4.0E; MS-RTC LM 8)"\n"Mozilla/5.0 (Android; Linux armv7l; rv:5.0) Gecko/20110615 Firefox/5.0 Fennec/5.0"\n"Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12B466 [FBAN/FBIOS;FBAV/37.0.0.21.273;FBBV/13822349;FBDV/iPhone6,1;FBMD/iPhone;FBSN/iPhone OS;FBSV/8.1.3;FBSS/2; FBCR/fido;FBID/phone;FBLC/fr_FR;FBOP/5]"\n"Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:40.0) Gecko/20100101 Firefox/40.0 Cyberfox/40.0"\n"Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mercury/8.7 Mobile/11B554a Safari/9537.53"\n"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.3; WOW64; Trident/7.0; .NET4.0E; .NET4.0C; .NET CLR 3.5.30729; .NET CLR 2.0.50727; .NET CLR 3.0.30729; GWX:QUALIFIED; MASMJS)"\n"Mozilla/5.0 (iPhone; CPU iPhone OS 7_1 like Mac OS X) AppleWebKit (KHTML, like Gecko) Mobile (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)"\n"Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; NP06; rv:11.0) like Gecko"\n"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.3; ARM; Trident/7.0; Touch; .NET4.0E; .NET4.0C; Tablet PC 2.0)"\n"Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.0.19) Gecko/2010062819 Firefox/3.0.19 Flock/2.6.1"\n"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; Touch; rv:11.0) like Gecko"\n"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/600.1.25 (KHTML, like Gecko) Version/8.0 Safari/600.1.25"\n"Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"' >.ua
# //login/logoff - - - - - - - - - - - - - - - - - - - - - - -
ACC=`w3m -debug -o accept_encoding=='*;q=0' "$URL/user" -o user_agent="$(shuf -n1 .ua)" | grep "\[level"`
[[ -n $ACC ]] && echo -e "\nWait to continue logged in as $ACC\n\nor press ENTER to sign in with another account" && \
	read -t10 && ACC=""
while [[ -z $ACC ]]; do
	function _login () {
# //2x
		$(w3m -debug -o accept_encoding=='*;q=0' "$URL/?exit" -o user_agent="$(shuf -n1 .ua)") 2&>-
		$(w3m -debug -o accept_encoding=='*;q=0' "$URL/?exit" -o user_agent="$(shuf -n1 .ua)") 2&>-
		unset username; unset password
		echo -n 'Username: '
		read username
		prompt="Password: "
		while IFS= read -p "$prompt" -r -s -n 1 char
			do
				if [[ $char == $'\0' ]]; then
					break
				fi
				prompt='🔒'
				password+="$char"
		done
		echo -e "\nIn case of error will repeat\n ..."
		echo -e "login=$username&pass=$password" >$HOME/.tmp/login.txt
		unset username; unset password
# //2x
		$(w3m -debug -post $HOME/.tmp/login.txt -o accept_encoding=='*;q=0' "$URL/?sign_in=1" -o user_agent="$(shuf -n1 .ua)") 2&>-
		$(w3m -debug -post $HOME/.tmp/login.txt -o accept_encoding=='*;q=0' "$URL/?sign_in=1" -o user_agent="$(shuf -n1 .ua)") 2&>-
	}
	_login
	clear
	ACC=`w3m -debug -o accept_encoding=='*;q=0' "$URL/user" -o user_agent="$(shuf -n1 .ua)" | grep "\[user"`
done
# //clan id - - - - - - - - - - - - - - - - - - - - - - - - -
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/clan -o user_agent="$(shuf -n1 .ua)"`
CLD=`echo $SRC | sed "s/\/clan\//\\n/g" | grep 'built\/' | cut -d\/ -f1`
# //game time ALPHA TEST- - - - - - - - - - - - - - - - - - -
TIME=$(echo $SRC | sed "s/\-->/\n/g" | grep --color '| <a c' | sed "s/|/\n/g" | head -n1 | tr -cd '[[:digit:]]')
TM0=`echo $TIME | cut -d0  -f1`
TM3=$(echo $SRC | sed "s/\-->/\n/g" | grep --color '| <a c' | sed "s/|/\n/g" | head -n1 | tr -cd '[[:digit:]]' | sed "s/0/3/g")
# //arena- - - - - - - - - - - - - - - - - - - - - - - - - - -
function _arena () {
# //take and help - arena clan quests
	for num in `seq 4 -1 3`; do $(w3m -debug -o accept_encoding=='*;q=0' $URL/clan/$CLD/quest/take/$num -o user_agent="$(shuf -n1 .ua)") 2&>-; done
	for num in `seq 4 -1 3`; do $(w3m -debug -o accept_encoding=='*;q=0' $URL/clan/$CLD/quest/help/$num -o user_agent="$(shuf -n1 .ua)") 2&>-; done
	clear
# //arena attack
	echo "Checking Arena..."
	SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/arena -o user_agent="$(shuf -n1 .ua)"`
	ACCESS=`echo $SRC | sed "s/arena/\\n/g" | grep "attack" | cut -d\/ -f4 | shuf -n1`
	HP=$(echo $SRC | sed "s/\<span/\\n/g" | grep "class='white'>" | head -n1 | tr -cd '[[:digit:]]')
	MP=$(echo $SRC | sed "s/\<span/\\n/g" | grep "alt='mp'/>" | head -n1 | tr -cd '[[:digit:]]')
	while [[ $MP -ge 50 && $HP -gt 1500 ]]; do
		echo " ⚔ Attacking..."
		SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/arena/attack/1/$ACCESS -o user_agent="$(shuf -n1 .ua)"`
		ACCESS=`echo $SRC | sed "s/arena/\\n/g" | grep "attack" | cut -d\/ -f4 | shuf -n1`
		HP=$(echo $SRC | sed "s/\<span/\\n/g" | grep "class='white'>" | head -n1 | tr -cd '[[:digit:]]')
		MP=$(echo $SRC | sed "s/\<span/\\n/g" | grep "alt='mp'/>" | head -n1 | tr -cd '[[:digit:]]')
	done
# //end and delete help - arena clan quests
	for num in `seq 4 -1 3`; do $(w3m -debug -o accept_encoding=='*;q=0' $URL/clan/$CLD/quest/deleteHelp/$num -o user_agent="$(shuf -n1 .ua)") 2&>-; done
	for num in `seq 4 -1 3`; do $(w3m -debug -o accept_encoding=='*;q=0' $URL/clan/$CLD/quest/end/$num -o user_agent="$(shuf -n1 .ua)") 2&>-; done
# //end sage quest
	$(w3m -debug -o accept_encoding=='*;q=0' $URL/quest/end/1 -o user_agent="$(shuf -n1 .ua)") 2&>-
	echo -e "Arena (✔)\n"
# //bag sell itens
	$(w3m -debug -o accept_encoding=='*;q=0' $URL/inv/bag/sellAll/1/ -o user_agent="$(shuf -n1 .ua)") 2&>-
	echo -e " 👜 The items in the bag were sold (✔)\n"
}
# //trade- - - - - - - - - - - - - - - - - - - - - - - - - - -
function _trade () {
	echo "Checking for gold exchange..."
	SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/trade/exchange -o user_agent="UA"`
	ACCESS=`echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| head -n1 | cut -d\= -f2 | cut -d\' -f1`
	EXIST=`echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| head -n1 | cut -d\/ -f3`
	while [[ $EXIST == silver ]]; do
		echo ' 💰 +1 Gold...'
		SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/trade/exchange/silver/1?r=$ACCESS -o user_agent="$(shuf -n1 .ua)"`
		ACCESS=`echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| head -n1 | cut -d\= -f2 | cut -d\' -f1`
		EXIST=`echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| head -n1 | cut -d\/ -f3`
	done
	echo -e "Exchange (✔)\n"
}
# //clandungeon - - - - - - - - - - - - - - - - - - - - - - -
function _clandungeon () {
	echo "Checking Clan Dungeon..."
	SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/clandungeon/?close" -o user_agent="$(shuf -n1 .ua)"`
	ACCESS=`echo $SRC | sed "s/clandungeon/\\n/g" | grep "attack" | cut -d\/ -f3 | shuf -n1`
	EXIST=`echo $SRC | sed "s/clandungeon/\\n/g" | grep "attack" | cut -d\/ -f2 | shuf -n1`
	while [[ $EXIST == attack ]]; do
		echo " ⚔ Attacking..."
		SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/clandungeon/attack/$ACCESS -o user_agent="$(shuf -n1 .ua)"`
		ACCESS=`echo $SRC | sed "s/clandungeon/\\n/g" | grep "attack" | cut -d\/ -f3 | shuf -n1`
		EXIST=`echo $SRC | sed "s/clandungeon/\\n/g" | grep "attack" | cut -d\/ -f2 | shuf -n1`
	done
	echo -e "Clan Dungeon (✔)\n"
}
# //campaign- - - - - - - - - - - - - - - - - - - - - - - - -
function _campaign () {
	echo "Checking campaign..."
	SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/campaign -o user_agent="$(shuf -n1 .ua)"`
	ENTER=`echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1 | cut -d\/ -f3`
	ACCESS=`echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1`
	while [[ -n $ENTER ]]; do
		SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL$ACCESS -o user_agent="$(shuf -n1 .ua)"`
		echo $ACCESS
		ENTER=`echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1 | cut -d\/ -f3`
		ACCESS=`echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1`
	done
	echo -e "campaign (✔)\n"
}
# //career- - - - - - - - - - - - - - - - - - - - - - - - - -
# // /career/attack/?r=8781779
function _career () {
	echo "Checking career..."
	SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/career -o user_agent="$(shuf -n1 .ua)"`
	ENTER=`echo $SRC | sed "s/href='/\n/g" | grep "/career/" | grep "/attack/"`
	ACCESS=`echo $SRC | sed "s/href='/\n/g" | grep "/career/" | grep "/attack/" | cut -d\' -f1`
	while [[ -n $ENTER ]]; do
		SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL$ACCESS -o user_agent="$(shuf -n1 .ua)"`
		echo $ACCESS
		ENTER=`echo $SRC | sed "s/href='/\n/g" | grep "/career/" | grep "/attack/"`
		ACCESS=`echo $SRC | sed "s/href='/\n/g" | grep "/career/" | grep "/attack/" | cut -d\' -f1`
	done
	echo -e "career (✔)\n"
}
# // // // // // // // // // // // // // // // // // // // //
# //coliseum - - - - - - - - - - - - - - - - - - - - - - - -
function _coliseum () {
# //enterFight
	PAGE=coliseum
	echo "$PAGE"
	$(w3m -debug -o accept_encoding=='*;q=0' $URL/?out_gate_confirm=true -o user_agent="$(shuf -n1 .ua)") 2&>-
	w3m -debug -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="UA" | head -n10 | tail -n6 | sed "/\[2hit/d;/\[str/d;/combat/d"
	sleep 5
	SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$(shuf -n1 .ua)"`
	ACTION=atk
	ACTION2=atkrnd
	ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep 'enterFight' | cut -d\/ -f3`
	echo " 👣 Entering..."
	SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/$PAGE/enterFight/$ACCESS/?end_fight=true" -o user_agent="$(shuf -n1 .ua)"`
# //wait
	echo " 😴 Waiting..."
	EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep 'leaveFight' | cut -d\/ -f2`
	while [[ $EXIST == leaveFight ]]; do
		SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$(shuf -n1 .ua)"`
		EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep 'leaveFight' | cut -d\/ -f2`
		echo -e " 💤 	..."
	done
	HPER=34 # //heal on 34% - defaut
	RPER=12 # //random if enemy have +12% hp - default
	_fights
}
# //undying - -- - - - - - - - - - - - - - - - - - - - - - - - -
function _undying () {
	ARENA=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | cut -d\/ -f5 | tr -cd "[[:digit:]]") && w3m -debug -o accept_encoding=='*;q=0' "$URL/arena/attack/1/$ARENA/?fullmana=true" -o user_agent="$(shuf -n1 .ua)" | grep "\[1"
# //enterGame
	PAGE=undying
	echo "$PAGE"
	w3m -debug -o accept_encoding=='*;q=0' $URL/$PAGE/enterGame -o user_agent="UA" | head -n10 | tail -n6 | sed "/\[2hit/d;/\[str/d;/combat/d"
	sleep 5
# //
	echo " 👣 Entering..."
	SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$(shuf -n1 .ua)"`
# //wait
	echo " 😴 Waiting..."
	EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep '\/mana\/' | cut -d\/ -f2`
	while [[ $EXIST != mana && $TIME -ge 100000 && $TIME -lt 100500 || $EXIST != mana && $TIME -ge 160000 && $TIME -lt 160500 || $EXIST != mana && $TIME -ge 220000 && $TIME -lt 220500 ]]; do
		SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$(shuf -n1 .ua)"`
		EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep '\/mana\/' | cut -d\/ -f2`
		echo -e " 💤 	..."
	done
# //
	ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "mana\/" | cut -d\/ -f3`
	SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/mana/$ACCESS -o user_agent="$(shuf -n1 .ua)"`
	ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "hit\/" | cut -d\/ -f3`
	while [[ $EXIST == hit ]]; do
		echo -e " 🎲 hiting..."
		SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/hit/$ACCESS -o user_agent="$(shuf -n1 .ua)"`
		ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "hit\/" | cut -d\/ -f3`
		EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "hit\/" | cut -d\/ -f2`
		sleep 6
	done
}
# //fights- - -- - - - - - - - - - - - - - - - - - - - - - - - -
function _fights (){
	ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f3`
	EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f2`
	WDRED=`echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4` #white/dred
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
	HEAL=`expr $FULL \* $HPER \/ 100`
	while [[ $EXIST == $ACTION ]]; do
		HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
		HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n3 | tail -1 | cut -d\< -f1 |cut -d\; -f2 | tr -cd '[[:digit:]]')
# //heal - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#		if [[ $WDRED == dred && $HP1 -lt $HEAL ]]; then
		if [[ $HP1 -lt $HEAL ]]; then
			echo "HP < $HPER%"
			echo -e " 💕 You: $HP1 - $HP2 :enemy"
			SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/heal/$ACCESS -o user_agent="$(shuf -n1 .ua)"`
			ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f3`
			EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f2`
			WDRED=`echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4` #white
			HP1=$HPFULL
			HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n3 | tail -1 | cut -d\< -f1 |cut -d\; -f2 | tr -cd '[[:digit:]]')
			sleep 5
# //random - - - - - - - - - - - - - - - - - - - - - - - - - - -
		elif [[ $WDRED == white && `expr $HP1 + $HP1 \* $RPER \/ 100` -lt $HP2 ]]; then
			HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
			echo -e " 🎲 You: $HP1 - $HP2 :enemy"
			SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/$ACTION2/$ACCESS -o user_agent="$(shuf -n1 .ua)"`
			ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f3`
			EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f2`
			WDRED=`echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4` #white
			HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
			HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n3 | tail -1 | cut -d\< -f1 |cut -d\; -f2 | tr -cd '[[:digit:]]')
			sleep 4
# //dodge - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		else
			echo -e " 💃 You: $HP1 - $HP2 :enemy"
			SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/dodge/$ACCESS -o user_agent="$(shuf -n1 .ua)"`
			ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f3`
			EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f2`
			WDRED=`echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4` #white
			HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
			HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n3 | tail -1 | cut -d\< -f1 |cut -d\; -f2 | tr -cd '[[:digit:]]')
			sleep 4
		fi
	done
# //view - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	echo ""
	w3m -debug -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$(shuf -n1 .ua)"| head -n14 | tail -n9 | sed "/\[user\]/d;/\[arrow\]/d;/\[arrow\]/d;/\]\ \[/d" | grep "\["
	echo "$PAGE (✔)"
}
# //play - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function _play () {
# //ALPHA TEST
	#while [[ -z $TM0 && $TM3 -gt 310000 && $TM3 -lt 395459 || $TIME -gt 224000 && $TIME -lt 235959 || $TIME -gt 101000 && $TIME -lt 102300 || $TIME -gt 104000 && $TIME -lt 105300 || $TIME -gt 111000 && $TIME -lt 122300 || $TIME -gt 124000 && $TIME -lt 135300 || $TIME -gt 141000 && $TIME -lt 145300 || $TIME -gt 151000 && $TIME -lt 155300 || $TIME -gt 161000 && $TIME -lt 162300 || $TIME -gt 164000 && $TIME -lt 185300 || $TIME -gt 191000 && $TIME -lt 205300 || $TIME -gt 211000 && $TIME -lt 215300 || $TIME -gt 221000 && $TIME -lt 222300 ]]; do
		_arena
		_career
		_clandungeon
		_trade
		_campaign
		_coliseum
		_stop
# //game time ALPHA TEST- - - - - - - - - - - - - - - - - - - -
		TIME=$(echo $SRC | sed "s/\-->/\n/g" | grep --color '| <a c' | sed "s/|/\n/g" | head -n1 | tr -cd '[[:digit:]]')
		TM0=`echo $TIME | cut -d0  -f1`
		TM3=$(echo $SRC | sed "s/\-->/\n/g" | grep --color '| <a c' | sed "s/|/\n/g" | head -n1 | tr -cd '[[:digit:]]' | sed "s/0/3/g")
		sleep 2
	#done
# //ALPHA TEST
	#while [[ -z $TM0 && $TM3 -gt 395459 && $TM3 -le 395959 || $TIME -gt 155459 && $TIME -lt 160500 || $TIME -gt 215559 && $TIME -lt 220500 ]]; do
		#_undying
# //game time ALPHA TEST- - - - - - - - - - - - - - - - - - - - -
		TIME=$(echo $SRC | sed "s/\-->/\n/g" | grep --color '| <a c' | sed "s/|/\n/g" | head -n1 | tr -cd '[[:digit:]]')
		TM0=`echo $TIME | cut -d0  -f1`
		TM3=$(echo $SRC | sed "s/\-->/\n/g" | grep --color '| <a c' | sed "s/|/\n/g" | head -n1 | tr -cd '[[:digit:]]' | sed "s/0/3/g")
		sleep 2
	#done

# //Valley of the Immortals 100000
# //Clan coliseum 103000
# //Clan tournament 110000
# //King of the Immortals 123000
# //Ancient Altars 140000
# //Clan coliseum 150000
# //Valley of the Immortals 160000
# //King of the Immortals 163000
# //Clan tournamentb190000
# //Ancient Altars 210000
# //Valley of the Immortals 220000
# //King of the Immortals 223000
}
while true; do
	_play
	sleep 2
done
exit
