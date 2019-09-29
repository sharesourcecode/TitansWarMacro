#!/bin/bash
clear
echo -e "Starting..."
mkdir -p $HOME/.tmp
cd $HOME/.tmp
termux-wake-lock &> /dev/null
UA=`cat $HOME/braveua`
URL='http://furiadetitas.net'
ACC=`w3m -debug -o accept_encoding=='*;q=0' "$URL/user" -o user_agent="$UA" | grep "\[level"`
[[ -n $ACC ]] && echo -e "\nWait to continue logged in as $ACC\n\nor press ENTER to sign in with another account" && \
read -t10 && ACC=""
while [[ -z $ACC ]]; do
function _login () {
$(w3m -debug -o accept_encoding=='*;q=0' "$URL/?exit" -o user_agent="$UA") 2&>-
$(w3m -debug -o accept_encoding=='*;q=0' "$URL/?exit" -o user_agent="$UA") 2&>-
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
$(w3m -debug -post $HOME/.tmp/login.txt -o accept_encoding=='*;q=0' "$URL/?sign_in=1" -o user_agent="$UA") 2&>-
$(w3m -debug -post $HOME/.tmp/login.txt -o accept_encoding=='*;q=0' "$URL/?sign_in=1" -o user_agent="$UA") 2&>-
}
_login
clear
ACC=`w3m -debug -o accept_encoding=='*;q=0' "$URL/user" -o user_agent="$UA" | grep "\[user"`
done
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/clan -o user_agent="$UA"`
CLD=`echo $SRC | sed "s/\/clan\//\\n/g" | grep 'built\/' | cut -d\/ -f1`
TIME=$(echo $SRC | sed "s/\-->/\n/g" | grep --color '| <a c' | sed "s/|/\n/g" | head -n1 | tr -cd '[[:digit:]]')
TM0=`echo $TIME | cut -d0  -f1`
TM3=$(echo $SRC | sed "s/\-->/\n/g" | grep --color '| <a c' | sed "s/|/\n/g" | head -n1 | tr -cd '[[:digit:]]' | sed "s/0/3/g")
#kill - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function _stop () {
echo -e "\n[Press ENTER for stop or wait to continue...]"
read -t13
[[ $? = 0 ]] && kill -9 $$
reset
}
#arena- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function _arena () {
for num in `seq 4 -1 3`; do $(w3m -debug -o accept_encoding=='*;q=0' $URL/clan/$CLD/quest/take/$num -o user_agent="$UA") 2&>-; done
for num in `seq 4 -1 3`; do $(w3m -debug -o accept_encoding=='*;q=0' $URL/clan/$CLD/quest/help/$num -o user_agent="$UA") 2&>-; done
clear
echo "Checking Arena..."
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/arena -o user_agent="$UA"`
ACCESS=`echo $SRC | sed "s/arena/\\n/g" | grep "attack" | cut -d\/ -f4 | shuf -n1`
HP=$(echo $SRC | sed "s/\<span/\\n/g" | grep "class='white'>" | head -n1 | tr -cd '[[:digit:]]')
MP=$(echo $SRC | sed "s/\<span/\\n/g" | grep "alt='mp'/>" | head -n1 | tr -cd '[[:digit:]]')
while [[ $MP -ge 50 && $HP -gt 1500 ]]; do
echo " ⚔ Attacking..."
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/arena/attack/1/$ACCESS -o user_agent="$UA"`
ACCESS=`echo $SRC | sed "s/arena/\\n/g" | grep "attack" | cut -d\/ -f4 | shuf -n1`
HP=$(echo $SRC | sed "s/\<span/\\n/g" | grep "class='white'>" | head -n1 | tr -cd '[[:digit:]]')
MP=$(echo $SRC | sed "s/\<span/\\n/g" | grep "alt='mp'/>" | head -n1 | tr -cd '[[:digit:]]')
done
for num in `seq 4 -1 3`; do $(w3m -debug -o accept_encoding=='*;q=0' $URL/clan/$CLD/quest/deleteHelp/$num -o user_agent="$UA") 2&>-; done
for num in `seq 4 -1 3`; do $(w3m -debug -o accept_encoding=='*;q=0' $URL/clan/$CLD/quest/end/$num -o user_agent="$UA") 2&>-; done
$(w3m -debug -o accept_encoding=='*;q=0' $URL/quest/end/1 -o user_agent="$UA") 2&>-
echo -e "Arena (✔)\n"
$(w3m -debug -o accept_encoding=='*;q=0' $URL/inv/bag/sellAll/1/ -o user_agent="$UA") 2&>-
echo -e " 👜 The items in the bag were sold (✔)\n"
}
#trade- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function _trade () {
echo "Checking for gold exchange..."
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/trade/exchange -o user_agent="UA"`
ACCESS=`echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| head -n1 | cut -d\= -f2 | cut -d\' -f1`
EXIST=`echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| head -n1 | cut -d\/ -f3`
while [[ $EXIST == silver ]]; do
echo ' 💰 +1 Gold...'
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/trade/exchange/silver/1?r=$ACCESS -o user_agent="$UA"`
ACCESS=`echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| head -n1 | cut -d\= -f2 | cut -d\' -f1`
EXIST=`echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| head -n1 | cut -d\/ -f3`
done
echo -e "Exchange (✔)\n"
}
#clandungeon - - - - - - - - - - - - - - - - - - - - - - - - - -
function _clandungeon () {
echo "Checking Clan Dungeon..."
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/clandungeon/?close" -o user_agent="$UA"`
ACCESS=`echo $SRC | sed "s/clandungeon/\\n/g" | grep "attack" | cut -d\/ -f3 | shuf -n1`
EXIST=`echo $SRC | sed "s/clandungeon/\\n/g" | grep "attack" | cut -d\/ -f2 | shuf -n1`
while [[ $EXIST == attack ]]; do
echo " ⚔ Attacking..."
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/clandungeon/attack/$ACCESS -o user_agent="$UA"`
ACCESS=`echo $SRC | sed "s/clandungeon/\\n/g" | grep "attack" | cut -d\/ -f3 | shuf -n1`
EXIST=`echo $SRC | sed "s/clandungeon/\\n/g" | grep "attack" | cut -d\/ -f2 | shuf -n1`
done
echo -e "Clan Dungeon (✔)\n"
}
#campaign- - - - - - - - - - - - - - - - - - - - - - - - - - - -
function _campaign () {
echo "Checking campaign..."
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/campaign -o user_agent="$UA"`
ENTER=`echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1 | cut -d\/ -f3`
ACCESS=`echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1`
while [[ -n $ENTER ]]; do
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL$ACCESS -o user_agent="$UA"`
echo $ACCESS
ENTER=`echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1 | cut -d\/ -f3`
ACCESS=`echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1`
done
echo -e "campaign (✔)\n"
}
#career- - - - - - - - - - - - - - - - - - - - - - - - - - - -
#/career/attack/?r=8781779
function _career () {
echo "Checking career..."
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/career -o user_agent="$UA"`
ENTER=`echo $SRC | sed "s/href='/\n/g" | grep "/career/" | grep "/attack/"`
ACCESS=`echo $SRC | sed "s/href='/\n/g" | grep "/career/" | grep "/attack/" | cut -d\' -f1`
while [[ -n $ENTER ]]; do
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL$ACCESS -o user_agent="$UA"`
echo $ACCESS
ENTER=`echo $SRC | sed "s/href='/\n/g" | grep "/career/" | grep "/attack/"`
ACCESS=`echo $SRC | sed "s/href='/\n/g" | grep "/career/" | grep "/attack/" | cut -d\' -f1`
done
echo -e "career (✔)\n"
}
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

#coliseum - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function _coliseum () {
#enterFight
PAGE=coliseum
echo "$PAGE"
$(w3m -debug -o accept_encoding=='*;q=0' $URL/?out_gate_confirm=true -o user_agent="$UA") 2&>-
w3m -debug -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="UA" | head -n10 | tail -n6 | sed "/\[2hit/d;/\[str/d;/combat/d"
sleep 5
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$UA"`
ACTION=atk
ACTION2=atkrnd
ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep 'enterFight' | cut -d\/ -f3`
echo " 👣 Entering..."
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/$PAGE/enterFight/$ACCESS/?end_fight=true" -o user_agent="$UA"`
#wait
echo " 😴 Waiting..."
EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep 'leaveFight' | cut -d\/ -f2`
while [[ $EXIST == leaveFight ]]; do
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$UA"`
EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep 'leaveFight' | cut -d\/ -f2`
echo -e " 💤 	..."
done
HPER=34 #heal on 34% - defaut
RPER=12 #random if enemy have +12% hp - default
_fights
}
#undying - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function _undying () {
ARENA=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/arena/quit -o user_agent="$UA" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | cut -d\/ -f5 | tr -cd "[[:digit:]]") && w3m -debug -o accept_encoding=='*;q=0' "$URL/arena/attack/1/$ARENA/?fullmana=true" -o user_agent="$UA" | grep "\[1"
#enterGame
PAGE=undying
echo "$PAGE"
w3m -debug -o accept_encoding=='*;q=0' $URL/$PAGE/enterGame -o user_agent="UA" | head -n10 | tail -n6 | sed "/\[2hit/d;/\[str/d;/combat/d"
sleep 5
#
echo " 👣 Entering..."
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$UA"`
#wait
echo " 😴 Waiting..."
EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep '\/mana\/' | cut -d\/ -f2`
while [[ $EXIST != mana && $TIME -ge 100000 && $TIME -lt 100500 || $EXIST != mana && $TIME -ge 160000 && $TIME -lt 160500 || $EXIST != mana && $TIME -ge 220000 && $TIME -lt 220500 ]]; do
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$UA"`
EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep '\/mana\/' | cut -d\/ -f2`
echo -e " 💤 	..."
done
#
ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "mana\/" | cut -d\/ -f3`
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/mana/$ACCESS -o user_agent="$UA"`
ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "hit\/" | cut -d\/ -f3`
while [[ $EXIST == hit ]]; do
echo -e " 🎲 hiting..."
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/hit/$ACCESS -o user_agent="$UA"`
ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "hit\/" | cut -d\/ -f3`
EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "hit\/" | cut -d\/ -f2`
sleep 6
done
}
#fights- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function _fights (){
ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f3`
EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f2`
WDRED=`echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4` #white/dred
FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
HEAL=`expr $FULL \* $HPER \/ 100`
while [[ $EXIST == $ACTION ]]; do
HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n3 | tail -1 | cut -d\< -f1 |cut -d\; -f2 | tr -cd '[[:digit:]]')
#heal - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [[ $WDRED == dred && $HP1 -lt $HEAL ]]; then
echo "HP red & $FULL • $HPER ÷ 100 = $HEAL"
echo -e " 💕 You: $HP1 - $HP2 :enemy"
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/heal/$ACCESS -o user_agent="$UA"`
ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f3`
EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f2`
WDRED=`echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4` #white
HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n3 | tail -1 | cut -d\< -f1 |cut -d\; -f2 | tr -cd '[[:digit:]]')
sleep 5
#random - - - - - - - - - - - - - - - - - - - - - - - - - - - -
elif [[ $WDRED == white && `expr $HP1 + $HP1 \* $RPER \/ 100` -lt $HP2 ]]; then
echo -e " 🎲 You: $HP1 - $HP2 :enemy"
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/$ACTION2/$ACCESS -o user_agent="$UA"`
ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f3`
EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f2`
WDRED=`echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4` #white
HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n3 | tail -1 | cut -d\< -f1 |cut -d\; -f2 | tr -cd '[[:digit:]]')
sleep 4
#dodge - - - - - - - - - - - - - - - - - - - - - - - - - - - -
else
echo -e " 💃 You: $HP1 - $HP2 :enemy"
SRC=`w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/$PAGE/dodge/$ACCESS -o user_agent="$UA"`
ACCESS=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f3`
EXIST=`echo $SRC | sed "s/\/$PAGE/\\n/g" | grep "$ACTION\/" | cut -d\/ -f2`
WDRED=`echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\' -f4` #white
HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n3 | tail -1 | cut -d\< -f1 |cut -d\; -f2 | tr -cd '[[:digit:]]')
sleep 4
fi
done
#view - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo ""
w3m -debug -o accept_encoding=='*;q=0' $URL/$PAGE -o user_agent="$UA"| head -n14 | tail -n9 | sed "/\[user\]/d;/\[arrow\]/d;/\[arrow\]/d;/\]\ \[/d" | grep "\["
echo "$PAGE (✔)"
}
#play - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function _play () {
while [[ -z $TM0 && $TM3 -gt 310000 && $TM3 -lt 395459 || $TIME -gt 224000 && $TIME -lt 235959 || $TIME -gt 101000 && $TIME -lt 102300 || $TIME -gt 104000 && $TIME -lt 105300 || $TIME -gt 111000 && $TIME -lt 122300 || $TIME -gt 124000 && $TIME -lt 135300 || $TIME -gt 141000 && $TIME -lt 145300 || $TIME -gt 151000 && $TIME -lt 155300 || $TIME -gt 161000 && $TIME -lt 162300 || $TIME -gt 164000 && $TIME -lt 185300 || $TIME -gt 191000 && $TIME -lt 205300 || $TIME -gt 211000 && $TIME -lt 215300 || $TIME -gt 221000 && $TIME -lt 222300 ]]; do
_arena
_career
_clandungeon
_trade
_campaign
_coliseum
_stop
#time
TIME=$(echo $SRC | sed "s/\-->/\n/g" | grep --color '| <a c' | sed "s/|/\n/g" | head -n1 | tr -cd '[[:digit:]]')
TM0=`echo $TIME | cut -d0  -f1`
TM3=$(echo $SRC | sed "s/\-->/\n/g" | grep --color '| <a c' | sed "s/|/\n/g" | head -n1 | tr -cd '[[:digit:]]' | sed "s/0/3/g")
sleep 2
done
while [[ -z $TM0 && $TM3 -gt 395459 && $TM3 -le 395959 || $TIME -gt 155459 && $TIME -lt 160500 || $TIME -gt 215559 && $TIME -lt 220500 ]]; do
_undying
#time
TIME=$(echo $SRC | sed "s/\-->/\n/g" | grep --color '| <a c' | sed "s/|/\n/g" | head -n1 | tr -cd '[[:digit:]]')
TM0=`echo $TIME | cut -d0  -f1`
TM3=$(echo $SRC | sed "s/\-->/\n/g" | grep --color '| <a c' | sed "s/|/\n/g" | head -n1 | tr -cd '[[:digit:]]' | sed "s/0/3/g")
sleep 2
done

#Valley of the Immortals 100000
#Clan coliseum 103000
#Clan tournament 110000
#King of the Immortals 123000
#Ancient Altars 140000
#Clan coliseum 150000
#Valley of the Immortals 160000
#King of the Immortals 163000
#Clan tournamentb190000
#Ancient Altars 210000
#Valley of the Immortals 220000
#King of the Immortals 223000
}
while true; do
_play
sleep 2
done
exit
