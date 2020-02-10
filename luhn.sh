#!/bin/bash
#!Coded by Suleman Malik
#!www.sulemanmalik.com

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
RESTORE='\033[0m'
ln(){
  echo -e "\033[0;34m---------------------------------------------\033[0m"
}
ban(){
echo -e '''
    _           _             
 \_|_)         | |            
   |           | |     _  _   
  _|    |   |  |/ \   / |/ |  /
 (/\___/ \_/|_/|   |_/  |  |_/
                                       
by \033[0;33m@sulemanmalik_3\t\t\033[0;32mV1.0
'''
}
validate(){
  inp=$(echo $1$2$3$4 | sed 's/ //g')
  if ! [[ $inp =~ ^[+-]?[0-9]+$ ]];then ln;echo -e "${RED}[!] Input is non-numeric! Try again...${RESTORE}";ln;exit 1; fi
}
main(){
luhn=$1
sum=0
len=${#1}
for (( i=0; i<${#luhn}; i++)); do
  num=${luhn:$i:1}
  if [ $((i % 2)) -eq 0 ]; then sum=$((sum + num)); else num=$((2 * num))
  if [ $num -gt 9 ]; then num=$((${num:0:1} + ${num:1:1}));else num=$num; fi
  sum=$((sum + num)); fi
done
mod=$(($sum*9))
if [ $((sum % 10)) -eq 0 ]; then
  ln; echo -e "${GREEN}[+] ${luhn} is Valid${RESTORE}\n[+] Input Length: ${GREEN}${len}${RESTORE}"
  chk=$(echo ${luhn} | sed 's/.*\(.\)/\1/')
  echo -e "${YELLOW}[-] Checksum: ${RED}${chk}${RESTORE}"
else
  checksum_d1=$(echo ${mod} | sed "s/.*\(.\)/\1/")
  verify=$(echo ${luhn}${checksum_d1})
  check=$(echo ${verify})
  sumx=0
  for (( j=0; j<${#check}; j++)); do
    numx=${check:$j:1}
    if [ $((j % 2)) -eq 0 ]; then sumx=$((sumx + numx)); else numx=$((2 * numx))
    if [ $numx -gt 9 ]; then numx=$((${numx:0:1} + ${numx:1:1}));else numx=$numx; fi
    sumx=$((sumx + numx)); fi
  done
  if [ $((sumx % 10 )) -eq 0 ]; then ln; 
    echo -e "${RED}[!] ${luhn} is Invalid\n${GREEN}[+]${RESTORE} ${luhn}${GREEN}${checksum_d1}${RESTORE} is Valid\n[+] Input Length: ${GREEN}${len}\n${RESTORE}${YELLOW}[-] Checksum: ${GREEN}${checksum_d1}${RESTORE}"; 
    else ln; echo -e "${RED}[!] Invalid number for Luhn algorithm!${RESTORE}"; fi
fi
}; clear; ban; validate $1$2$3$4; main $inp; ln;
