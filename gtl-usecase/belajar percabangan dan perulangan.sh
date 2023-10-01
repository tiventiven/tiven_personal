#!/usr/bin/env bash
var_i="$1"
for ((i=1; i<var_i; i++))
do
   for ((j=1; j<=i; j++))
   do
# Gunakan percabangan if untuk mengatur berapa banyak bintang yang dicetak pada setiap baris
        # if (( i <= 3 )); then
             echo -n "* "
        # else
        #     echo -n "** "
        # fi
   done
   echo
done