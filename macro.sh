#!/bin/bash
clear
termux-wake-lock &> /dev/null
UA=`cat $HOME/braveua`
URL='http://furiadetitas.net'
CLD='1271'
#cv
function _cv () {
w3m -o user_agent="$UA" "$URL/cave" | grep "Iniciar a minera" && \
#tk5
$(w3m -o user_agent="$UA" "$URL/clan/$CLD/quest/take/5") 2&>-
lynx -accept_all_cookies "$URL/?exit&sign_in=1" -cmd_script=$HOME/sm/minerar.txt -useragent="$UA" || \
w3m -o user_agent="$UA" "$URL/cave" | grep "Acelerar" || \
lynx -accept_all_cookies "$URL/?exit&sign_in=1" -cmd_script=$HOME/sm/novapesquisa.txt -useragent="$UA"
w3m -o user_agent="$UA" "$URL/cave" | grep "for derrotado" && \
lynx -accept_all_cookies "$URL/?exit&sign_in=1" -cmd_script=$HOME/sm/gather.txt -useragent="$UA"
w3m -o user_agent="$UA" "$URL/cave/runaway" | grep "Entrar na" && \
lynx -accept_all_cookies "$URL/?exit&sign_in=1" -cmd_script=$HOME/sm/runaway.txt -useragent="$UA"
#ed5
$(w3m -o user_agent="$UA" "$URL/clan/$CLD/quest/end/5") 2&>-
}
#td
function _td () {
w3m -o user_agent="$UA" "$URL/trade/exchange" | grep "\[arrow\]Troca \[silver\]" && \
lynx -accept_all_cookies "$URL/?exit&sign_in=1" -cmd_script=$HOME/sm/troca.txt -useragent="$UA"
}
#ar
function _ar () {
#tk3,4
$(w3m -o user_agent="$UA" "$URL/clan/$CLD/quest/take/3") 2&>-
$(w3m -o user_agent="$UA" "$URL/clan/$CLD/quest/take/4") 2&>-
lynx -accept_all_cookies "$URL/?exit&sign_in=1" -cmd_script=$HOME/sm/arena.txt -useragent="$UA"
#ed3,4
$(w3m -o user_agent="$UA" "$URL/clan/$CLD/quest/end/3") 2&>-
$(w3m -o user_agent="$UA" "$URL/clan/$CLD/quest/end/4") 2&>-
}
function _mp () {
HME=`w3m "$URL/arena" | grep 'mp '`
MPE=`echo $HME | cut -d" " -f 5`
HPE=`echo $HME | cut -d" " -f 2`
}
while true; do
_cv
_mp
while [[ $MPE -ge 50 && $HPE -gt 1500 ]]; do
_ar
_mp
done
_td
#sll
$(w3m -o user_agent="$UA" "$URL/inv/bag/sellAll/1/") 2&>-
#grb
$(w3m -o user_agent="$UA" "$URL/clan/$CLD/gerb/"`shuf -n1 $HOME/sm/numbergerb.txt`"") 2&>-
sleep 600
reset
done
exit
