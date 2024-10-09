#!/bin/sh

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

cript_decript () {

 #/General variables
 local CriptChars="200,201,202,203,204,205,206,207,210,211,212,213,214,215,216,217,220,221,222,223,224,225,226,227,230,231,232,233,234,235,236,237,240,241,242,243,244,245,246,247,250,251,252,253,254,255,256,257,260,261,262,263,264,265,266,267,270,271,272,273,274,275,276,277,300,301,302,303,304,305,306,307,310,311,312,313,314,315,316,317,320,321,322,323,324,325,326,327,330,331,332,333,334,335,336,337,340,341,342,343,344,345,346,347,350,351,352,353,354,355,356,357,360,361,362,363,364,365,366,367,370,371,372,373,374,375,376,377"
 local DecriptChars="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9,А,Б,В,Г,Д,Е,Ё,Ж,З,И,Й,К,Л,М,Н,О,П,Р,С,Т,У,Ф,Х,Ц,Ч,Ш,Щ,Ъ,Ы,Ь,Э,Ю,Я,а,б,в,г,д,е,ё,ж,з,и,й,к,л,м,н,о,п,р,с,т,у,ф,х,ц,ч,ш,щ,ъ,ы,ь,э,ю,я"
 local AllCript=$(echo "$CriptChars" | awk -F "," '{print NF}')
 local AllDecript=$(echo "$DecriptChars" | awk -F "," '{print NF}')

 #/Run mode
 ArgPipe="$@"

 #/Temporary file
 dir_ram="$HOME/cript/"

 #/Input for decryption
 if [ "$ArgPipe" = '-d' ]; then
  local RandomChars=$(awk -F':' '{print $2}' cript_file | base64 -d)
  local ReceiverPipe=$(awk -F':' '{print $1}' cript_file)
  echo "$ReceiverPipe"
 #/Input for encryption
 else
  while read ReceiverData; do
   local ReceiverPipe=$(printf "$ReceiverData\n" | sed 's/\(.\)/\1,/g;s/,$//' | base64 -w 0)
  done
 fi

 #/test input

 #/Builds $PositionOrder with the total
 #\positions of elements in $CriptChars
 ElementsPosition () {
  printf "\nFormulating random factor..."

  local PositionOrder=""

  for OriginalPosition in $(seq 1 $AllCript); do
   local AddElement="$OriginalPosition"

   if [ -n "$PositionOrder" ]; then
    PositionOrder="$PositionOrder,$AddElement"
   else
    PositionOrder="$AddElement"
   fi

   printf "."
  done

  #/Randomly select a number of positions
  #\in $PositionOrder relative to the total
  #\number of elements in $DecriptChars
  SelectedPositions=$(echo "$PositionOrder" | tr ',' '\n' | shuf | head -n "$AllDecript" | tr '\n' ',' | sed 's/,$//')
  printf "\nFormulated random factor ✓\n"
  echo "SelectedPositions: $SelectedPositions"
 }

 #/Run just to encrypt
 if [ "$ArgPipe" != '-d' ]; then
  ElementsPosition
  printf "\nGenerating random encryption key..."

  #/Constructs $RandomChars with substitute
  #\characters for $DecriptChars based on some
  #\random positions of selected elements
  #\referring to $CriptChars in $SelectedPositions
  local RandomChars=""

  for ReferencePosition in $(seq 1 $AllDecript); do
   local OriginalPosition=$(echo "$SelectedPositions" | awk -F',' -v pos="$ReferencePosition" 'NR==pos')
   echo "ReferencePosition: $ReferencePosition, OriginalPosition: $OriginalPosition"

   # Verifique se OriginalPosition está vazio
   if [ -z "$OriginalPosition" ]; then
    echo "Aviso: OriginalPosition está vazio para ReferencePosition $ReferencePosition. Pulando..."
    continue  # Pula para a próxima iteração
   fi

   local CharAtPosition=$(echo "$CriptChars" | awk -F',' -v pos="$OriginalPosition" 'NR==pos')
   echo "CharAtPosition: $CharAtPosition"

   if [ -n "$RandomChars" ]; then
    RandomChars="${RandomChars},${CharAtPosition}"
   else
    RandomChars="${CharAtPosition}"
   fi

   printf "."
  done

  echo "RandomChars: $RandomChars"

 fi

 if [ "$ArgPipe" != '-d' ]; then
  printf "\nKey generated ✓\n"
  printf "Encrypting..."
 else
  printf "Trying to use a recent key to decrypt"
 fi

 #/Sensitive data will be worked into a
 #\temporary file with a random name.
 mkdir -p "$dir_ram"
 cript_file="$dir_ram/data.fa"
 printf "$ReceiverPipe\n" > "$cript_file"

 #/Encrypt or decrypt data
 for ReferencePosition in $(seq 1 $AllDecript); do
  local OpenChars=$(echo "$DecriptChars" | awk -F',' -v pos="$ReferencePosition" 'NR==pos')
  local ClosedChars=$(echo "$RandomChars" | awk -F',' -v pos="$ReferencePosition" 'NR==pos')

  # Debugging: Print values of OpenChars and ClosedChars
  echo "OpenChars: '$OpenChars', ClosedChars: '$ClosedChars'"

  if [ -z "$ClosedChars" ] || [ -z "$OpenChars" ]; then
   echo "Aviso: ClosedChars ou OpenChars está vazio. Pulando..."
   continue  # Pula para a próxima iteração
  fi

  if [ "$ArgPipe" = '-d' ]; then
   sed -i "s#\o$ClosedChars#$OpenChars#g" "$cript_file"
  else
   sed -i "s#$OpenChars#\o$ClosedChars#g" "$cript_file"
  fi

  printf "."
 done

 #/Stores the key
 if [ "$ArgPipe" != '-d' ]; then
  printf %b ":$(echo "$RandomChars" | base64 -w 0)" >> "$cript_file"
  cat "$cript_file" > cript_file
  echo ""
  cat "$cript_file" | awk -F':' '{print $1}'
  echo " 👆😎👍 Your password is securely saved. 🔐"
 else
  mkdir -p "$dir_ram"
  cookie="$dir_ram/cdata.fa"
  cat "$cript_file" | base64 -d | sed 's/,//g' > "$cookie"
  echo ""
  cat "$cookie"
 fi

 rm -rf "$cookie" "$cript_file" "$dir_ram"
 unset CriptChars cript_file cookie DecriptChars dir_ram RandomChars
}

printf %b "$1\n" | cript_decript "$1
