#!/usr/bin/env bash
# i8-final.sh — Mensagem final e tabela de resumo

BASE="$HOME/SixxTerm"

printf "\n\n\n"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

COL1=28
COL2=60
TABLE_WIDTH=$((COL1 + COL2 + 3))

print_center_table() {
    local term_width
    term_width=$(tput cols 2>/dev/null || echo 80)
    local pad=$(( (term_width - TABLE_WIDTH) / 2 ))
    (( pad < 0 )) && pad=0

    lines=(
        "┌$(printf '─%.0s' $(seq 1 $COL1))┬$(printf '─%.0s' $(seq 1 $COL2))┐"
        "│$(printf '%-*s' $COL1 " SECÇÃO")│$(printf '%-*s' $COL2 " DESCRIÇÃO")│"
        "├$(printf '─%.0s' $(seq 1 $COL1))┼$(printf '─%.0s' $(seq 1 $COL2))┤"
        "│$(printf '%-*s' $COL1 " Caminho do tema")│$(printf '%-*s' $COL2 " $BASE")│"
        "│$(printf '%-*s' $COL1 " Shell")│$(printf '%-*s' $COL2 " Zsh com plugins")│"
        "│$(printf '%-*s' $COL1 " Fonte")│$(printf '%-*s' $COL2 " SF Mono Regular")│"
        "│$(printf '%-*s' $COL1 " Banner")│$(printf '%-*s' $COL2 " $BASE/themes/banner.sh")│"
        "│$(printf '%-*s' $COL1 " Restaurar")│$(printf '%-*s' $COL2 " bash ~/restore.sh")│"
        "│$(printf '%-*s' $COL1 " Aplicar mudanças")│$(printf '%-*s' $COL2 " Feche e abra o Termux")│"
        "└$(printf '─%.0s' $(seq 1 $COL1))┴$(printf '─%.0s' $(seq 1 $COL2))┘"
    )

    for line in "${lines[@]}"; do
        printf "%*s%s\n" "$pad" "" "$line"
    done
}

# ── Título ───────────────────────────────────────────────────────
term_width=$(tput cols 2>/dev/null || echo 80)
title="BEM-VINDO AO SIXXTERM"
pad=$(( (term_width - ${#title}) / 2 ))
printf "%*s${CYAN}%s${RESET}\n\n" "$pad" "" "$title"

# ── Tabela ───────────────────────────────────────────────────────
print_center_table

# ── Rodapé ───────────────────────────────────────────────────────
printf "\n"
footer1="O seu Termux está pronto com o tema SixxTerm!"
footer2="Divirta-se a personalizar e explorar! — by @ytsixx"
pad=$(( (term_width - ${#footer1}) / 2 ))
printf "%*s${GREEN}%s${RESET}\n" "$pad" "" "$footer1"
pad=$(( (term_width - ${#footer2}) / 2 ))
printf "%*s${YELLOW}%s${RESET}\n\n" "$pad" "" "$footer2"