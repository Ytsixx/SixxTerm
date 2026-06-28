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

source "$BASE/lib/progress_bar.sh" 2>/dev/null

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
        echo -e "  ${GRAY}│${RESET} ${GREEN}backup${RESET}           ${GRAY}│${RESET} Fazer backup das configs no /sdcard    ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}doctor${RESET}           ${GRAY}│${RESET} Verificar dependências e plugins       ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET} ${GREEN}status${RESET}           ${GRAY}│${RESET} Ver o que está instalado vs falta      ${GRAY}│${RESET}"
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

# ── Backup ──────────────────────────────────────────────────────
    backup)
        BACKUP_DIR="/sdcard/SixxTerm-backups"
        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
        BACKUP_FILE="$BACKUP_DIR/sixxterm_$TIMESTAMP.zip"

        if [ ! -d "/sdcard" ]; then
            echo -e "\n  ${RED}[✗] Sem acesso ao /sdcard.${RESET}"
            echo -e "  ${YELLOW}[!] Execute: termux-setup-storage${RESET}\n"
            exit 1
        fi

        if ! command -v zip >/dev/null 2>&1; then
            echo -e "\n  ${YELLOW}[!] Instalando zip...${RESET}"
            pkg install -y zip >/dev/null 2>&1
        fi

        mkdir -p "$BACKUP_DIR"
        echo -e "\n  ${CYAN}[*] Iniciando backup...${RESET}"

        zip -r "$BACKUP_FILE" \
            "$BASE" \
            "$HOME/.zshrc" \
            "$HOME/.termux" \
            "$HOME/.profile" \
            >/dev/null 2>&1 &
        ZIP_PID=$!

        progress_bar "Criando backup" 5 &
        BAR_PID=$!

        wait $ZIP_PID
        ZIP_RC=$?
        kill $BAR_PID 2>/dev/null
        wait $BAR_PID 2>/dev/null
        printf '\033[?25h'  # garante cursor visível

        if [ $ZIP_RC -eq 0 ]; then
            SIZE=$(du -sh "$BACKUP_FILE" | awk '{print $1}')
            echo -e "  ${GREEN}[✓] Backup criado com sucesso!${RESET}"
            echo -e "  ${GRAY}●${RESET} Ficheiro:  ${WHITE}$BACKUP_FILE${RESET}"
            echo -e "  ${GRAY}●${RESET} Tamanho:   ${WHITE}$SIZE${RESET}\n"
        else
            echo -e "  ${RED}[✗] Falha ao criar backup.${RESET}\n"
            exit 1
        fi
        ;;

# ── Doctor ──────────────────────────────────────────────────────
    doctor)
        echo -e "\n  ${CYAN}SixxTerm — Diagnóstico${RESET}\n"

        _check() {
            local label="$1"
            local cmd="$2"
            if command -v "$cmd" >/dev/null 2>&1; then
                echo -e "  ${GREEN}[✓]${RESET} ${WHITE}$label${RESET}"
            else
                echo -e "  ${RED}[✗]${RESET} ${WHITE}$label${RESET}  ${GRAY}(não encontrado: $cmd)${RESET}"
            fi
        }

        _check_file() {
            local label="$1"
            local path="$2"
            if [ -e "$path" ]; then
                echo -e "  ${GREEN}[✓]${RESET} ${WHITE}$label${RESET}"
            else
                echo -e "  ${RED}[✗]${RESET} ${WHITE}$label${RESET}  ${GRAY}(não encontrado: $path)${RESET}"
            fi
        }

        echo -e "  ${GRAY}── Pacotes ───────────────────────────────${RESET}"
        _check "bash"          bash
        _check "zsh"           zsh
        _check "git"           git
        _check "curl"          curl
        _check "zip"           zip
        _check "jq"            jq
        _check "fzf"           fzf
        _check "go"            go
        _check "logo-ls"       logo-ls
        _check "figlet"        figlet
        _check "neofetch"      neofetch

        echo -e "\n  ${GRAY}── Plugins Zsh ───────────────────────────${RESET}"
        PLUGINS_DIR="$BASE/plugins"
        _check_file "zsh-autosuggestions"     "$PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
        _check_file "zsh-syntax-highlighting" "$PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        _check_file "zsh-autocomplete"        "$PLUGINS_DIR/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
        _check_file "bgnotify"                "$PLUGINS_DIR/bgnotify/bgnotify.plugin.zsh"
        _check_file "zsh-fzf-history-search"  "$PLUGINS_DIR/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh"

        echo -e "\n  ${GRAY}── Ficheiros ─────────────────────────────${RESET}"
        _check_file "banner.sh"         "$BASE/themes/banner.sh"
        _check_file "progress_bar.sh"   "$BASE/lib/progress_bar.sh"
        _check_file "json_format.sh"    "$BASE/lib/json_format.sh"
        _check_file "updater.sh"        "$BASE/lib/updater.sh"
        _check_file ".zshrc"            "$HOME/.zshrc"
        _check_file "font.ttf"          "$HOME/.termux/font.ttf"
        _check_file "colors.properties" "$HOME/.termux/colors.properties"
        echo -e ""
        ;;

# ── Status ──────────────────────────────────────────────────────
    status)
        echo -e "\n  ${CYAN}SixxTerm — Status da Instalação${RESET}\n"

        ok=0
        fail=0

        _status() {
            local label="$1"
            local check="$2"
            if eval "$check" >/dev/null 2>&1; then
                echo -e "  ${GREEN}●${RESET} ${WHITE}$label${RESET}"
                (( ok++ ))
            else
                echo -e "  ${RED}○${RESET} ${GRAY}$label${RESET}"
                (( fail++ ))
            fi
        }

        echo -e "  ${GRAY}── Componentes ───────────────────────────${RESET}"
        _status "Zsh instalado"              "command -v zsh"
        _status "logo-ls instalado"          "command -v logo-ls"
        _status "fzf instalado"              "command -v fzf"
        _status "jq instalado"               "command -v jq"
        _status "go instalado"               "command -v go"
        _status "Plugins Zsh presentes"      "[ -d '$BASE/plugins' ] && ls '$BASE/plugins' | grep -q zsh"
        _status "Banner configurado"         "[ -x '$BASE/themes/banner.sh' ]"
        _status "Fonte instalada"            "[ -f '$HOME/.termux/font.ttf' ]"
        _status "Cores configuradas"         "[ -f '$HOME/.termux/colors.properties' ]"
        _status ".zshrc presente"            "[ -f '$HOME/.zshrc' ]"
        _status "Script de restore presente" "[ -f '$HOME/restore.sh' ]"

        echo -e "\n  ${GRAY}─────────────────────────────────────────${RESET}"
        echo -e "  ${GREEN}$ok instalado(s)${RESET}  ${RED}$fail em falta${RESET}\n"
        ;;

        # ── About ───────────────────────────────────────────────────────
    about|autor|dono|sixx|ytsixx)
        echo -e "\n  ${CYAN}SixxTerm — Sobre o Projeto${RESET}\n"
        echo -e "  ${GRAY}╭─────────────────────────────────────────╮${RESET}"
        echo -e "  ${GRAY}│${RESET}                                         ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}   ${CYAN}⬡${RESET}  ${WHITE}Sixx${RESET}  ${GRAY}·${RESET}  ${GREEN}@ytsixx${RESET}                   ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}                                         ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}   ${GRAY}Dev${RESET}     ${WHITE}Node.js · Bash · Termux${RESET}       ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}   ${GRAY}From${RESET}    ${WHITE}Mocambique${RESET}                    ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}   ${GRAY}GitHub${RESET}  ${WHITE}github.com/Ytsixx${RESET}             ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}                                         ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}   ${GRAY}WA${RESET}      ${WHITE}+258 86 081 7689${RESET}              ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}   ${GRAY}IG${RESET}      ${WHITE}@ytsixx__${RESET}                     ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}   ${GRAY}FB${RESET}      ${WHITE}sixx hxrx${RESET}                     ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}                                         ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}   ${GRAY}Projeto${RESET} ${WHITE}SixxTerm v$(cat "$BASE/version.txt" 2>/dev/null || echo "1.0.0")${RESET}               ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}   ${GRAY}Licenca${RESET} ${WHITE}MIT${RESET}                           ${GRAY}│${RESET}"
        echo -e "  ${GRAY}│${RESET}                                         ${GRAY}│${RESET}"
        echo -e "  ${GRAY}╰─────────────────────────────────────────╯${RESET}"
        echo -e "\n  ${GRAY}Feito com amor em  City Lichinga${RESET}\n"
        ;;
        

# ── Comando desconhecido ─────────────────────────────────────────
    *)
        echo -e "\n  ${RED}[✗] Comando desconhecido: $cmd${RESET}"
        echo -e "  ${YELLOW}[!] Use: sixxterm help${RESET}\n"
        exit 1
        ;;
        
esac