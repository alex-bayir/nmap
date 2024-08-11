#!/bin/zsh
dir="$HOME/dev/projects/nmap/report-parser"
pwsh -command "cd $dir && cpi '$HOME/Рабочий стол/out.xml' '$dir/out.xml' && ./parser.ps1 -path out.xml"