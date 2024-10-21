#!/bin/bash
nmap -v -O -A -sV -sC --script vuln,malware,exploit,auth -iL /shared/targets.txt --excludefile /shared/excluded.txt -oX /shared/out.xml && xsltproc /shared/out.xml -o /shared/out.html

# nmap -sU -sX -pT:21,22,23,U:53,137 91.206.58.106