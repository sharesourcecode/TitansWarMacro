#!/bin/bash

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

. ~/twm/info.lib
colors
RUN=$(cat $HOME/twm/runmode_file)
cd $HOME/twm

script_ads () {
 if [ "$RUN" != '-boot' ] && [ -f "$HOME/twm/ads_file" ] && [ -s "$HOME/twm/ads_file" ] && [ "$(cat $HOME/twm/ads_file)" != "$(date +%d)" ] ; then
  if [ "$(cat $HOME/twm/ads_file 2> /dev/null)" != "$(date +%d)" ] ; then
   xdg-open "https://masto.pt/invite/XzjEurkb" #xdg-open "https://apps.disroot.org/search?q=Shell+Script&category_general=on&language=pt-BR&time_range=&safesearch=1&theme=beetroot"
   echo $(date +%d) >$HOME/twm/ads_file
  fi
 else
   echo $(date +%d) >$HOME/twm/ads_file
 fi
}
script_ads

printf "${BLACK_CYAN}\n Starting...\n👉 Please wait...☕👴${COLOR_RESET}\n"
#. ~/twm/info.lib
script_slogan
sleep 1s
#/termux
if [ -d /data/data/com.termux/files/usr/share/doc ] ; then
 termux-wake-lock
 LS='/data/data/com.termux/files/usr/share/doc'
else
 LS='/usr/share/doc'
fi

#/sources
cd ~/twm
#/twm.sh before sources <<
#. clandmgfight.lib
. requeriments.lib ; . loginlogoff.lib ; . online.lib
. flagfight.lib ; . clanid.lib ; . crono.lib ; . arena.lib ; . coliseum.lib
. campaign.lib ; . run.lib ; . altars.lib ; . clanfight.lib
. clancoliseum.lib ; . king.lib ; . undying.lib ; . clandungeon.lib
. trade.lib ; . career.lib ; . cave.lib ; . allies.lib ; . svproxy.lib ; . check.lib
#/twm.sh after sources >>
#/functions
twm_start () {
 if echo "$RUN"|grep -q -E '[-]cv' ; then
  cave_start
 elif echo "$RUN"|grep -q -E '[-]cl' ; then
  twm_play
 elif echo "$RUN"|grep -q -E '[-]boot' ; then
  twm_play
 else
  twm_play
 fi
}
func_unset () {
 unset HP1 HP2 YOU USER CLAN ENTER ENTER ATK ATKRND DODGE HEAL BEXIT OUTGATE LEAVEFIGHT WDRED HLHP
}
if [ -f "$HOME/twm/ur_file" ] && [ -s "$HOME/twm/ur_file" ] ; then
 printf "${GREEN_BLACK} Starting with last settings used.${COLOR_RESET}\n"
 num=6
 for i in `seq 6 -1 1` ; do
  i=$((i - 1))
  if read -t 1 ; then
   >$HOME/twm/al_file
   >$HOME/twm/ur_file
   >$HOME/twm/fileAgent.txt
   unset UR
   unset UA
   unset AL
   break &>/dev/null
  fi
  printf " Hit${GOLD_BLACK} [Enter]${COLOR_RESET} to${GOLD_BLACK} reconfigure${GREEN_BLACK} ${i}s${COLOR_RESET}\n"
 done
fi
requer_func
func_proxy
login_logoff
if [ -n "$ALLIES" ] && [ "$RUN" != "-cv" ] ; then
 conf_allies
 clear
fi

func_cat
messages_info
while true ; do
 sleep 1s
 twm_start
done

#/sync
: ' comparing local package
if [ ! -z "$RUN" ] ; then
 :
else
 TWMKEY=$(curl https://codeberg.org/ueliton/auth/raw/branch/main/auth -s -L|base64 -d)
 SERVER='https://raw.githubusercontent.com/sharesourcecode/TitansWarMacro/master/'
 remote_count=$(curl ${SERVER}sourceinstall.lib -s -L|wc -c)
 if [ -e "$HOME/twm/sourceinstall.lib" ] ; then
  local_count=$(wc -c < "$HOME/twm/sourceinstall.lib")
 else
  local_count=1
 fi
 '
 #if awk -v remote="$remote_count" -v local="$local_count" 'BEGIN {if (remote == local) exit 0; else exit 1}' ; then
  : '
 else
  if ! curl -s --head --request GET titanswar.net|grep "200 OK" > /dev/null ; then
   printf "${WHITEb_BLACK}Network error! Please check your internet connection.${BLACK_RESET}\n"
   exit 1
  else
   rm $HOME/twm/easyinstall.s*
   curl ${SERVER}easyinstall.lib -s -L >$HOME/twm/easyinstall.lib
   rm $HOME/easyinstall.s*
   cp $HOME/twm/easyinstall.lib $HOME/easyinstall.lib
   SYNC=1
   chmod +x $HOME/easyinstall.lib
   . $HOME/easyinstall.lib
  fi
 fi
fi
'
