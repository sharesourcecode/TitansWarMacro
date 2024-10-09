#!/bin/sh

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

(
 RUN=$1
 echo "$RUN" >$HOME/twm/runmode_file
 while true; do
  pidf=$(jobs -l | awk '/sh.*twm\/twm\.lib/ { if (NR == 1) print $2 }')
  until [ -z "${pidf}" ]; do
   kill -9 ${pidf} 2>/dev/null
   pidf=$(jobs -l | awk '/sh.*twm\/twm\.lib/ { if (NR == 1) print $2 }')
   sleep 1s
  done
  run_mode () {
   if echo "$RUN"|grep -q -E '[-]cl'; then
    chmod +x $HOME/twm/twm.sh ; $HOME/twm/twm.sh
   elif echo "$RUN"|grep -q -E '[-]cv'; then
    chmod +x $HOME/twm/twm.sh ; $HOME/twm/twm.sh -cv
   elif echo "$RUN"|grep -q -E '[-]boot'; then
    echo '-boot' >$HOME/twm/runmode_file ; chmod +x $HOME/twm/twm.sh ; $HOME/twm/twm.sh -boot
   else
    echo '-boot' >$HOME/twm/runmode_file ; chmod +x $HOME/twm/twm.sh ; $HOME/twm/twm.sh -boot
   fi
  }
  run_mode
  sleep 0.1s
 done
)
