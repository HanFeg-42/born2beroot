#!/bin/bash

arc=`uname -a`
cpup=`lscpu | grep "Socket" | cut -d: -f2 | tr -d " "`
vcpu=`nproc`
MU=`free --mega | grep Mem | awk '{printf "%d/%dMB (%.2f%%)\n", $3, $2, ($3/$2) * 100}'`
DU=`df --total | grep total | awk '{printf "%d/%dGb (%d%%)\n", $3 / 1000, $2 / 1000000, $5}'`
cpul=`top -bn1 | grep "Cpu(s)" | awk '{print $7}' | cut -d, -f2 | awk '{printf "%.1f%%\n", 100 - $1}'`
LB=`who -b | awk '{print $3" "$4}'`
lvmu=`lsblk | grep lvm -q && echo "yes" || echo "no"`
ctcp=`netstat -t | awk 'NR > 2' | wc  -l`
ul=`who -u | wc -l`
ip=`hostname -I`
mac=`ip a | grep ether | awk '{printf "(%s)\n", $2}'`
exc=`journalctl _COMM=sudo -q | grep COMMAND | wc -l`

wall "	#Architecture: $arc
	#CPU physical : $cpup
	#vCPU : $vcpu
	#Memory Usage: $MU
	#Disk Usage: $DU
	#CPU load: $cpul
	#Last boot: $LB
	#LVM use: $lvmu
	#Connections TCP : $ctcp ESTABLISHED
	#User log: $ul
	#Network: IP $ip$mac
	#Sudo : $exc cmd"
