#!/usr/bin/env bash
# i5-theme.sh — Cores, propriedades do Termux, fonte e banner

BASE="$HOME/SixxTerm"
PLUGINS_DIR="$BASE/plugins"
TERMUX_DIR="$HOME/.termux"
LOG_DIR="$HOME/.cache/SixxTerm"
THEMES_DIR="$BASE/themes"

source "$BASE/lib/progress_bar.sh"

info()    { printf "\e[1;36m[*]\e[0m %s\n" "$1"; }
warn()    { printf "\e[1;33m[!]\e[0m %s\n" "$1"; }
success() { printf "\e[1;32m[✓]\e[0m %s\n" "$1"; }
erro()    { printf "\e[1;31m[✗]\e[0m %s\n" "$1"; }

mkdir -p "$TERMUX_DIR" "$LOG_DIR" "$THEMES_DIR"

# ── Cores estilo macOS ──────────────────────────────────────────
progress_bar "Aplicando paleta de cores (estilo macOS)" 1
cat > "$TERMUX_DIR/colors.properties" <<'EOF'
color0=#1e1e1e
color1=#ff5f56
color2=#4caf50
color3=#ffbd2e
color4=#5ac8fa
color5=#bf5af2
color6=#64d2ff
color7=#e5e5e5
color8=#6e6e6e
color9=#ff5f56
color10=#4caf50
color11=#ffbd2e
color12=#5ac8fa
color13=#bf5af2
color14=#64d2ff
color15=#ffffff
background=#1e1e1e
foreground=#e5e5e5
cursor=#4caf50
EOF
success "Paleta de cores aplicada!"

# ── Propriedades do Termux ──────────────────────────────────────
progress_bar "Aplicando configurações do terminal" 1
cat > "$TERMUX_DIR/termux.properties" <<'EOF'
allow-external-apps = true
terminal-cursor-blink-rate=600
terminal-cursor-style = underline
EOF
success "Configurações do terminal aplicadas!"

# ── Fonte SF Mono ───────────────────────────────────────────────
progress_bar "Instalando fonte SF Mono" 2
FONT_URL="https://raw.githubusercontent.com/Ytsixx/Projeto-Q/main/fonts/SFMonoRegular.otf"

if curl -L --silent --show-error --fail -o "$TERMUX_DIR/font.ttf" "$FONT_URL"; then
    success "Fonte SF Mono instalada em ~/.termux/font.ttf!"
else
    warn "Falha ao baixar SF Mono. Coloque font.ttf manualmente em ~/.termux/"
fi

# ── Banner estilo macOS ─────────────────────────────────────────
progress_bar "Gerando banner" 1
BANNER_SH="$THEMES_DIR/banner.sh"

cat > "$BANNER_SH" <<'EOF'
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
EOF

chmod +x "$BANNER_SH"
success "Tema configurado com sucesso!"