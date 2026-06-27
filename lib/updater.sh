#!/usr/bin/env bash
# lib/updater.sh — Verificador e atualizador do SixxTerm

BASE="$HOME/SixxTerm"
VERSION_LOCAL="$BASE/version.txt"
VERSION_URL="https://raw.githubusercontent.com/Ytsixx/SixxTerm/main/version.txt"

CYAN="\033[1;36m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

check_update() {
    local local_ver remote_ver
    local_ver=$(cat "$VERSION_LOCAL" 2>/dev/null || echo "0.0.0")
    remote_ver=$(curl -s --max-time 5 "$VERSION_URL" 2>/dev/null || echo "0.0.0")

    if [ "$remote_ver" != "0.0.0" ] && [ "$remote_ver" != "$local_ver" ]; then
        echo -e "\n  ${YELLOW}● Nova versão disponível: $remote_ver (atual: $local_ver)${RESET}"
        echo -e "  ${CYAN}  Execute: sixxterm update${RESET}\n"
    fi
}

do_update() {
    echo -e "${CYAN}[*] Atualizando SixxTerm...${RESET}"
    git -C "$BASE" pull --quiet && \
        echo -e "${GREEN}[✓] SixxTerm atualizado com sucesso!${RESET}" && \
        echo -e "${YELLOW}[!] Reinicie o Termux para aplicar.${RESET}" || \
        echo -e "\033[1;31m[✗] Falha ao atualizar.\033[0m"
}