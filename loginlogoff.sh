_loginlogoff () {
# /login/logoff
	ACC=$(w3m -debug $ENC "$URL/user" -o user_agent="$(shuf -n1 .ua)" | grep "\[level" | cut -d" " -f2)
#	ACC=$(lynx -cfg=~/twm/cfg1 "$URL/user" -useragent="$(shuf -n1 .ua)" | grep "\[level" | cut -d" " -f2)
	[[ -n $ACC && -n $URL ]] && i=5 && \
          until [[ $i -lt 1 ]]; do
		clear
		echo -e "[Wait to $ACC... ("$i"s) - ENTER to other account] \n"
                i=$[$i-1]; read -t1 && \
		ACC="" && break
        done
	clear
	while [[ -z $ACC && -n $URL ]]; do
		function _login () {
# /logoff2x
			$(w3m -debug $ENC "$URL/?exit" -o user_agent="$(shuf -n1 .ua)") 2&>-
			$(w3m -debug $ENC "$URL/?exit" -o user_agent="$(shuf -n1 .ua)") 2&>-
#			$(lynx -cfg=~/twm/cfg1 "$URL/?exit" -useragent="$(shuf -n1 .ua)") 2&>-
			unset username; unset password
			echo -e "\nIn case of error will repeat"
			echo -n 'Username: '
			read username
			echo -e "\n"
			prompt="Password: "
			charcount=0
			while IFS= read -p "$prompt" -r -s -n 1 char; do
# /Enter - accept password
			if [[ $char == $'\0' ]]; then
				break
			fi
# /Backspace
			if [[  $char  == $'\177' ]]; then
				if [ $charcount -gt 0 ]; then
					charcount=$((charcount - 1))
					prompt=$'\b \b'
					password="${password%?}"
				else
					prompt=''
				fi
			else
				charcount=$((charcount + 1))
				prompt='🔒'
				password+="$char"
			fi
			done
			echo -e "\n	Please wait..."
			echo -e "login=$username&pass=$password" >$HOME/.tmp/login.txt
# /login2x
#			$(echo -e "login=$username&pass=$password" | lynx -cfg=~/twm/cfg1 -post_data "$URL/?sign_in=1" -useragent="$(shuf -n1 .ua)") 2&>-
			unset username; unset password
			$(w3m -debug -post $HOME/.tmp/login.txt $ENC "$URL/?sign_in=1" -o user_agent="$(shuf -n1 .ua)") 2&>-
			$(w3m -debug -post $HOME/.tmp/login.txt $ENC "$URL/?sign_in=1" -o user_agent="$(shuf -n1 .ua)") 2&>-
			rm $HOME/.tmp/login.txt
		}
		_login
		clear
		ACC=$(w3m -debug $ENC "$URL/user" -o user_agent="$(shuf -n1 .ua)" | grep "\[user")
	done
}
