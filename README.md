# nmap
## scan
Scan with comand for example:
```shell
sudo nmap -v -O -A -sV -sC —script vuln,malware,exploit,auth -iL targets.txt —excludefile excluded.txt -oX out.xml && xsltproc out.xml -o out.html
```

## [parsing report](report-parser/ReadMe.md)
