#!/bin/bash

#Create directory for nmap files

mkdir nmap-$1
cd nmap-$1

#nmap scan

sudo nmap -sC -sV -Pn -oA $1-top100 --min-rate 2 --max-rate 100 --top-ports 100 $1

#Scan all ports
sudo nmap -Pn -p- -vv -oA $1-all-ports $1

#clean the results and get only open ports numbers 
grep open $1-all-ports.nmap | sed 's/\// /g' |cut -d " " -f 1 > $1.ports


#Final nmap scan 
sudo nmap -A -Pn -vv --min-rate 2 --max-rate 100 -p $(tr '\n' , $1.ports) -oA $1-final $1 


#UDP ports scaning
sudo nmap -sU -Pn -oA $1-UDP --top-ports 1000 $1 
