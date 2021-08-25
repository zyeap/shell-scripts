#!/usr/bin/env bash
# Bash script for getting essential system information

# Colors 
NC='\033[0m'
LGREEN='\033[1;32m'
YELLOW='\033[1;33m'

get_os() {
    os="$(grep PRETTY_NAME /etc/os-release)"
    os_formatted=${os:13:-1}
    os_bit_ver="$(uname -m)"
    echo -e "$os_formatted $os_bit_ver"
}

get_uptime() {
    uptime="$(uptime --pretty)"
    uptime_formatted=${uptime:2}
    echo -e $uptime_formatted
}

get_chassis() {
    chassis=$(< /sys/devices/virtual/dmi/id/chassis_vendor)
    chassis+=" $(< /sys/devices/virtual/dmi/id/product_version)"
    chassis+=" $(< /sys/devices/virtual/dmi/id/product_name)"
    echo -e $chassis
}

get_shell() {
    shell_path="$(echo $SHELL)"
    shell_name="${shell_path##*/}"
    shell="$($shell_name --version | head -n 1)"
    echo -e $shell
}

get_cpu() {
    cpu_raw="$(cat /proc/cpuinfo | grep "model name" | head -n 1)"
    cpu=${cpu_raw:13}   
    cpu="${cpu//(TM)}"
    cpu="${cpu//(tm)}"
    cpu="${cpu//(R)}"
    cpu="${cpu//(r)}"
    echo -e $cpu
}

get_mem(){
    mem_used="$(free -h | awk '/Mem/ {print $3}')"
    mem_total="$(free -h | awk '/Mem/ {print $2}')"
    echo -e "$mem_used / $mem_total"
}

echo "-------------------------------------------"
echo -e "Date:${YELLOW} $(date) ${NC}"
echo "-------------------------------------------"
echo -e "${LGREEN}Hostname:${NC} $(hostname)" 
echo -e "${LGREEN}Uptime:${NC} $(get_uptime)"
echo -e "${LGREEN}OS:${NC} $(get_os)"
echo -e "${LGREEN}Chassis:${NC} $(get_chassis)"
echo -e "${LGREEN}Kernel:${NC} $(uname -r)"
echo -e "${LGREEN}Shell:${NC} $(get_shell)"
echo "-------------------------------------------"
# CPU, RAM, Storage
echo -e "${LGREEN}CPU:${NC} $(get_cpu)"
echo -e "${LGREEN}RAM:${NC} $(get_mem)"
echo "-------------------------------------------"
# Network info (IP/netmask, DHCP, DNS)

