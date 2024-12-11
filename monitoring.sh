#!/bin/bash

arc=`uname -a`
cpup=`lscpu | grep "Socket" | cut -d: -f2 | tr -d " "`
vcpu=`nproc`
MU=`free --mega | grep Mem | awk '{printf "%d/%dMB (%.2f%%)\n", $3, $2, ($3/$2) * 100}'`
DU=`df --total | grep total | awk '{printf "%d/%dGb (%d%%)\n", $3 / 1000, $2 / 1000000, $5}'`
cpul=`top -bn1 | grep "Cpu(s)" | awk '{print $7}' | cut -d, -f2 | awk '{printf "%.1f%%\n", 100 - $1}'`
LB=`who -b | awk '{print $3" "$4}'`
lvmu=`lsblk | grep lvm -q && echo "yes" || echo "no"`
wall "	#Architecture: $arc
	#CPU physical : $cpup
	#vCPU : $vcpu
	#Memory Usage: $MU
	#Disk Usage: $DU
	#CPU load: $cpul
	#Last boot: $LB
	#LVM use: $lvmu
	#Connections TCP : 1 ESTABLISHED
	#User log: 1
	#Network: IP 10.0.2.15 (08:00:27:51:9b:a5)
	#Sudo : 42 cmd"
