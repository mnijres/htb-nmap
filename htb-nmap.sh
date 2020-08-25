#!/bin/bash

#Create directory for target nmap scan files

mkdir nmap-$1
cd nmap-$1

#nmap scan

sudo nmap -sC -sV -Pn -oA $1-top100 --min-rate 2 --max-rate 100 --top-ports 100 $1

#Scan all ports
sudo nmap -Pn -p- -vv -oA $1-all-ports $1

#clean the results and get only open ports numbers 
grep open $1-all-ports.nmap | sed 's/\// /g' |cut -d " " -f 1 > $1.clean

sed -z 's/\n/,/g'  $1.clean| sed 's/$/here/g'| sed 's/\,here//g' | rev  | cut -f2- |rev > $1-ports


#Final nmap scan 
sudo nmap -A -Pn -vv --min-rate 2 --max-rate 100 -p $(cat $1-ports) -oA $1-final $1 


#UDP scaning
sudo nmap -sU -Pn -oA $1-UDP --top-ports 1000 $1 

