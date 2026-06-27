#!/usr/bin/env bash
# bin/sixxterm.sh — Comando principal do SixxTerm

BASE="$HOME/SixxTerm"

CYAN="\033[1;36m"
WHITE="\033[1;37m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
GRAY="\033[0;90m"
RESET="\033[0m"

cmd="${1:-help}"

case "$cmd" in

# ── Sistema ─────────────────────────────────────────────────────
    help)
        echo -e "\n  ${CYAN}SixxTerm — Manual de Comandos${RESET}\n"
        echo -e "  ${GRAY}╭──────────────────┬────────────────────────────────────────╮${RESET}"
        echo -e "  ${GRAY}│${RESET} ${WHITE}COMANDO${RESET}          ${GRAY}│${RESET} ${WHITE}DESCRIÇÃO${RESET}                              ${GRAY}│${RESET}"
        echo -e "  ${GRAY}├──────────────────┼────────────────────────────────────────┤${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}help${RESET}             ${GRAY}│${RESET} Mostrar este manual                    ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}version${RESET}          ${GRAY}│${RESET} Ver versão instalada                   ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}update${RESET}           ${GRAY}│${RESET} Atualizar SixxTerm                     ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}restore${RESET}          ${GRAY}│${RESET} Restaurar Termux ao padrão             ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}reload${RESET}           ${GRAY}│${RESET} Recarregar configurações do Zsh        ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}info${RESET}             ${GRAY}│${RESET} Informações do sistema                 ${GRAY}│${RESET}"
        echo -e "  ${GRAY}├──────────────────┼────────────────────────────────────────┤${RESET}"
        echo -e "  ${GRAY}│${RESET} ${CYAN}Aliases Gerais${RESET}   ${GRAY}│${RESET}                                        ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}c${RESET}                ${GRAY}│${RESET} clear                                  ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}q${RESET}                ${GRAY}│${RESET} exit                                   ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}sd${RESET}               ${GRAY}│${RESET} cd /sdcard                             ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}dl${RESET}               ${GRAY}│${RESET} cd /sdcard/Download                    ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}reload${RESET}           ${GRAY}│${RESET} source ~/.zshrc                        ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}neo${RESET}              ${GRAY}│${RESET} neofetch                               ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}pacupg${RESET}           ${GRAY}│${RESET} pkg upgrade                            ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}pacupd${RESET}           ${GRAY}│${RESET} pkg update                             ${GRAY}│${RESET}"
        echo -e "  ${GRAY}├──────────────────┼────────────────────────────────────────┤${RESET}"
        echo -e "  ${GRAY}│${RESET} ${CYAN}Aliases Git${RESET}      ${GRAY}│${RESET}                                        ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}gs${RESET}               ${GRAY}│${RESET} git status                             ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}ga${RESET}               ${GRAY}│${RESET} git add .                              ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}gc \"msg\"${RESET}         ${GRAY}│${RESET} git commit -m                          ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}gp${RESET}               ${GRAY}│${RESET} git push                               ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}gpl${RESET}              ${GRAY}│${RESET} git pull                               ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}gcb${RESET}              ${GRAY}│${RESET} git checkout -b                        ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}gl${RESET}               ${GRAY}│${RESET} git log --oneline --graph              ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}gst${RESET}              ${GRAY}│${RESET} git stash                              ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}gstp${RESET}             ${GRAY}│${RESET} git stash pop                          ${GRAY}│${RESET}"
        echo -e "  ${GRAY}├──────────────────┼────────────────────────────────────────┤${RESET}"
        echo -e "  ${GRAY}│${RESET} ${CYAN}Aliases pnpm${RESET}     ${GRAY}│${RESET}                                        ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}pi${RESET}               ${GRAY}│${RESET} pnpm install                           ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}pa${RESET}               ${GRAY}│${RESET} pnpm add                               ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}pad${RESET}              ${GRAY}│${RESET} pnpm add -D                            ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}pd${RESET}               ${GRAY}│${RESET} pnpm run dev                           ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}pb${RESET}               ${GRAY}│${RESET} pnpm run build                         ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}px${RESET}               ${GRAY}│${RESET} pnpm dlx                               ${GRAY}│${RESET}"
        echo -e "  ${GRAY}├──────────────────┼────────────────────────────────────────┤${RESET}"
        echo -e "  ${GRAY}│${RESET} ${CYAN}Aliases npm${RESET}      ${GRAY}│${RESET}                                        ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}ni${RESET}               ${GRAY}│${RESET} npm install                            ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}nid${RESET}              ${GRAY}│${RESET} npm install --save-dev                 ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}nd${RESET}               ${GRAY}│${RESET} npm run dev                            ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}nb${RESET}               ${GRAY}│${RESET} npm run build                          ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}nx${RESET}               ${GRAY}│${RESET} npx                                    ${GRAY}│${RESET}"
        echo -e "  ${GRAY}├──────────────────┼────────────────────────────────────────┤${RESET}"
        echo -e "  ${GRAY}│${RESET} ${CYAN}Aliases Rede${RESET}     ${GRAY}│${RESET}                                        ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}myip${RESET}             ${GRAY}│${RESET} Ver IP público                         ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}localip${RESET}          ${GRAY}│${RESET} Ver IP local                           ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}pingg${RESET}            ${GRAY}│${RESET} ping google.com                        ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}speedtest${RESET}        ${GRAY}│${RESET} Testar velocidade                      ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}ports${RESET}            ${GRAY}│${RESET} Ver portas abertas                     ${GRAY}│${RESET}"
        echo -e "  ${GRAY}├──────────────────┼────────────────────────────────────────┤${RESET}"
        echo -e "  ${GRAY}│${RESET} ${CYAN}Aliases Termux${RESET}   ${GRAY}│${RESET}                                        ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}tb${RESET}               ${GRAY}│${RESET} termux-battery-status                  ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}tw${RESET}               ${GRAY}│${RESET} termux-wifi-connectioninfo             ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}tc${RESET}               ${GRAY}│${RESET} termux-clipboard-get                   ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}topen${RESET}            ${GRAY}│${RESET} termux-open                            ${GRAY}│${RESET}"
        echo -e "  ${GRAY}╰──────────────────┴────────────────────────────────────────╯${RESET}"
        echo -e "\n  ${GRAY}by @ytsixx${RESET}\n"
        ;;

# ── Versão ──────────────────────────────────────────────────────
    version)
        local_ver=$(cat "$BASE/version.txt" 2>/dev/null || echo "desconhecida")
        echo -e "\n  ${CYAN}SixxTerm${RESET} — versão ${GREEN}$local_ver${RESET}\n"
        ;;

# ── Update ──────────────────────────────────────────────────────
    update)
        echo -e "\n  ${CYAN}[*] Verificando atualizações...${RESET}"
        local_ver=$(cat "$BASE/version.txt" 2>/dev/null || echo "0.0.0")
        remote_ver=$(curl -s --max-time 5 \
            "https://raw.githubusercontent.com/Ytsixx/SixxTerm/main/version.txt" \
            2>/dev/null || echo "0.0.0")

        if [ "$remote_ver" = "0.0.0" ]; then
            echo -e "  ${RED}[✗] Não foi possível verificar a versão remota.${RESET}\n"
            exit 1
        fi

        if [ "$remote_ver" = "$local_ver" ]; then
            echo -e "  ${GREEN}[✓] Já tens a versão mais recente: $local_ver${RESET}\n"
        else
            echo -e "  ${YELLOW}[!] Nova versão disponível: $remote_ver (atual: $local_ver)${RESET}"
            echo -e "  ${CYAN}[*] Atualizando...${RESET}"
            git -C "$BASE" pull --quiet && \
                echo -e "  ${GREEN}[✓] Atualizado para $remote_ver!${RESET}" && \
                echo -e "  ${YELLOW}[!] Reinicie o Termux para aplicar.${RESET}\n" || \
                echo -e "  ${RED}[✗] Falha ao atualizar.${RESET}\n"
        fi
        ;;

# ── Restore ─────────────────────────────────────────────────────
    restore)
        bash "$HOME/restore.sh"
        ;;

# ── Reload ──────────────────────────────────────────────────────
    reload)
        echo -e "  ${CYAN}[*] Recarregando configurações...${RESET}"
        source "$HOME/.zshrc"
        echo -e "  ${GREEN}[✓] Configurações recarregadas!${RESET}\n"
        ;;

# ── Info ────────────────────────────────────────────────────────
    info)
        local_ver=$(cat "$BASE/version.txt" 2>/dev/null || echo "desconhecida")
        echo -e "\n  ${CYAN}SixxTerm — Informações do Sistema${RESET}\n"
        echo -e "  ${GRAY}●${RESET} Versão:    ${WHITE}$local_ver${RESET}"
        echo -e "  ${GRAY}●${RESET} Android:   ${WHITE}$(getprop ro.build.version.release)${RESET}"
        echo -e "  ${GRAY}●${RESET} Modelo:    ${WHITE}$(getprop ro.product.model)${RESET}"
        echo -e "  ${GRAY}●${RESET} Shell:     ${WHITE}$SHELL${RESET}"
        echo -e "  ${GRAY}●${RESET} Uptime:    ${WHITE}$(uptime -p)${RESET}"
        echo -e "  ${GRAY}●${RESET} Memória:   ${WHITE}$(free -h | awk '/Mem/{print $3"/"$2}')${RESET}"
        echo -e "  ${GRAY}●${RESET} Armazen.:  ${WHITE}$(df -h /data | awk 'NR==2{print $3"/"$2}')${RESET}\n"
        ;;

# ── Comando desconhecido ─────────────────────────────────────────
    *)
        echo -e "\n  ${RED}[✗] Comando desconhecido: $cmd${RESET}"
        echo -e "  ${YELLOW}[!] Use: sixxterm help${RESET}\n"
        exit 1
        ;;
esac