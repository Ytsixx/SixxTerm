#!/usr/bin/env bash
# banner.sh — banner minimalista estilo macOS

red="\033[1;31m"
yellow="\033[1;33m"
green="\033[1;32m"
gray="\033[1;90m"
blue="\033[1;34m"
white="\033[1;37m"
reset="\033[0m"

os="Android $(getprop ro.build.version.release 2>/dev/null)"

echo -e "\n"
echo -e "  ${red}●${reset} ${yellow}●${reset} ${green}●${reset}   ${white}${PWD}${reset}"
echo -e "  ${gray}───────────────────────────────────────────${reset}"
echo -e "   ${blue}${os}${reset} ${gray}·${reset} by @ytsixx"
echo -e "\n"
