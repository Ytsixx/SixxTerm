#!/usr/bin/env bash
# banner.sh — banner minimalista estilo macOS

red="\033[1;31m"
yellow="\033[1;33m"
green="\033[1;32m"
gray="\033[1;90m"
blue="\033[1;34m"
cyan="\033[1;36m"
white="\033[1;37m"
reset="\033[0m"

# ── Dados do sistema ─────────────────────────────────────────────
os="Android $(getprop ro.build.version.release 2>/dev/null)"
ram_total=$(free -m 2>/dev/null | awk '/Mem/{print $2}')
ram_used=$(free -m 2>/dev/null | awk '/Mem/{print $3}')
disk_used=$(df -h /data 2>/dev/null | awk 'NR==2{print $3}')
disk_total=$(df -h /data 2>/dev/null | awk 'NR==2{print $2}')
local_ip=$(ip route get 1 2>/dev/null | awk '{print $7}' | head -1)
short_path=$(echo "$PWD" | sed "s|$HOME|~|")

# ── Barra de progresso com gradiente ────────────────────────────
_bar() {
    local used=$1
    local total=$2
    local width=12
    local filled=$(( used * width / total ))
    local empty=$(( width - filled ))
    local pct=$(( used * 100 / total ))

    local cor
    if (( pct < 50 )); then
        cor="\033[1;32m"
    elif (( pct < 80 )); then
        cor="\033[1;33m"
    else
        cor="\033[1;31m"
    fi

    local bar="" empty_bar=""
    (( filled > 0 )) && bar=$(printf '█%.0s' $(seq 1 $filled))
    (( empty > 0 ))  && empty_bar=$(printf '░%.0s' $(seq 1 $empty))

    printf "${cor}%s\033[0;90m%s${reset}" "$bar" "$empty_bar"
}

# ── Banner ───────────────────────────────────────────────────────
echo -e "\n"
echo -e "  ${red}●${reset} ${yellow}●${reset} ${green}●${reset}  ${gray}┃${reset}  ${cyan}@ytsixx${reset}  ${gray}┃${reset}  ${white}${os}${reset}"
echo -e "  ${gray}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${reset}"
echo -e "  ${cyan}▸${reset} ${gray}PATH${reset}   ${white}${short_path}${reset}"
printf "  ${cyan}▸${reset} ${gray}RAM ${reset}   $(_bar $ram_used $ram_total)  ${white}${ram_used}MB / ${ram_total}MB${reset}\n"
printf "  ${cyan}▸${reset} ${gray}DISK${reset}   $(_bar $(echo $disk_used | tr -d 'G') $(echo $disk_total | tr -d 'G'))  ${white}${disk_used} / ${disk_total}${reset}\n"
echo -e "  ${cyan}▸${reset} ${gray}IP  ${reset}   ${white}${local_ip:-N/A}${reset}"
echo -e "\n"
