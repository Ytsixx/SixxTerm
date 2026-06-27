#!/usr/bin/env bash
# i1-env.sh — Configuração do ambiente e banner

BASE="$HOME/SixxTerm"
LOG_DIR="$HOME/.cache/SixxTerm"
FIGLET_LOG="$LOG_DIR/figlet.log"

mkdir -p "$LOG_DIR"
rm -f "$FIGLET_LOG"
clear

# ── Verificar se está no Termux ─────────────────────────────────
if [ -z "$PREFIX" ] || [ ! -d "/data/data/com.termux" ]; then
    echo -e "\033[1;31m[✗] Este script deve ser executado no Termux!\033[0m"
    exit 1
fi

# ── Instalar sl e figlet ────────────────────────────────────────
( pkg install -y sl figlet >"$FIGLET_LOG" 2>&1 ) & pid=$!

while kill -0 "$pid" 2>/dev/null; do
    sl
done
wait "$pid"
rc=$?

clear

# ── Banner ──────────────────────────────────────────────────────
if [ $rc -eq 0 ]; then
    RED="\033[1;31m"
    GREEN="\033[1;32m"
    YELLOW="\033[1;33m"
    BLUE="\033[1;34m"
    MAGENTA="\033[1;35m"
    CYAN="\033[1;36m"
    RESET="\033[0m"
    cols=$(tput cols)

    figlet -f slant "Sixx-Term" | \
    awk -v width="$cols" -v r="$RED" -v g="$GREEN" -v y="$YELLOW" \
        -v b="$BLUE" -v m="$MAGENTA" -v c="$CYAN" -v reset="$RESET" \
    '{
        colors[1]=r; colors[2]=g; colors[3]=y;
        colors[4]=b; colors[5]=m; colors[6]=c;
        color=colors[(NR-1)%6+1];
        len=length($0);
        pad=int((width-len)/2);
        printf "%s%*s%s%s\n", color, pad, "", $0, reset;
    }'

    printf "\n"
    printf "\033[1;37m%*s\033[0m\n" $(( (cols + 20) / 2 )) "      Bem-vindo ao SixxTerm Installer"
    printf "\033[0;90m%*s\033[0m\n" $(( (cols + 16) / 2 )) "        v1.0.0 — by Ytsixx"
    printf "\n\n"
else
    echo -e "\033[1;33m[!] Falha ao instalar figlet/sl. Verifique: $FIGLET_LOG\033[0m"
fi