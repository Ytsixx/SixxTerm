#!/usr/bin/env bash
# install.sh — SixxTerm Installer
clear
set -euo pipefail

export BASE="$HOME/SixxTerm"
INSTALLER_DIR="$BASE/installer"

# ── Verificar se está no Termux ─────────────────────────────────
if [ -z "$PREFIX" ] || [ ! -d "/data/data/com.termux" ]; then
    echo -e "\033[1;31m[✗] Este script deve ser executado no Termux!\033[0m"
    exit 1
fi

# ── Verificar se o repositório existe ───────────────────────────
if [ ! -d "$BASE" ]; then
    echo -e "\033[1;31m[✗] Pasta $BASE não encontrada!\033[0m"
    echo -e "\033[1;33m[!] Clone o repositório primeiro:\033[0m"
    echo -e "    git clone https://github.com/Ytsixx/SixxTerm ~/SixxTerm"
    exit 1
fi

run_step() {
    local script="$1"
    if [ -f "$script" ]; then
        bash "$script"
    else
        echo -e "\033[1;31m[✗] Script não encontrado: $script\033[0m"
        exit 1
    fi
}

run_step "$INSTALLER_DIR/env/i1-env.sh"
run_step "$INSTALLER_DIR/core/i2-core.sh"
run_step "$INSTALLER_DIR/extra/i3-extra.sh"
run_step "$INSTALLER_DIR/plugins/i4-plugins.sh"
run_step "$INSTALLER_DIR/theme/i5-theme.sh"
run_step "$INSTALLER_DIR/shell/i6-shell.sh"
run_step "$INSTALLER_DIR/restore/i7-restore.sh"
run_step "$INSTALLER_DIR/final/i8-final.sh"