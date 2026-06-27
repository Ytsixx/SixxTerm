#!/usr/bin/env bash
#tema_black.sh - Colors, Termux properties, font & banner

BASE="$HOME/SixxTerm"
PLUGINS_DIR="$BASE/plugins"
TERMUX_DIR="$HOME/.termux"
LOG_DIR="$HOME/.cache/atexovi"
SHARED="$BASE/lib/progress_bar.sh"
if [ -f "$SHARED" ]; then
    source "$SHARED"
fi

command -v info >/dev/null 2>&1 || info() { printf "\e[1;36m[*]\e[0m %s\n" "$1"; }
command -v warn >/dev/null 2>&1 || warn() { printf "\e[1;33m[!]\e[0m %s\n" "$1"; }
command -v success >/dev/null 2>&1 || success() { printf "\e[1;32m[OK]\e[0m %s\n" "$1"; }
command -v progress_bar >/dev/null 2>&1 || progress_bar() { printf "[*] %s\n" "$1"; }

info "Escrevendo colors.properties"
progress_bar "Aplicando paleta de cores (estilo macOS)" 1
mkdir -p "$TERMUX_DIR"
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

info "Escrevendo termux.properties"
progress_bar "Aplicando configuracao do terminal" 1
cat > "$TERMUX_DIR/termux.properties" <<'EOF'
allow-external-apps = true
terminal-cursor-blink-rate=600
terminal-cursor-style = underline
EOF

info "Baixando fonte (JetBrains Mono - estilo macOS)..."
progress_bar "Instalando fonte personalizada" 3
FONT_URL="https://github.com/JetBrains/JetBrainsMono/releases/latest/download/JetBrainsMono-2.304.zip"
FONT_TMP="$LOG_DIR/jetbrainsmono.zip"
FONT_TMP_DIR="$LOG_DIR/jetbrainsmono-extracted"

mkdir -p "$LOG_DIR"
if curl -L --silent --show-error --fail -o "$FONT_TMP" "$FONT_URL"; then
    mkdir -p "$FONT_TMP_DIR"
    if unzip -o -q "$FONT_TMP" -d "$FONT_TMP_DIR"; then
        REGULAR_FONT=$(find "$FONT_TMP_DIR" -iname "JetBrainsMono-Regular.ttf" | head -n1)
        if [ -n "$REGULAR_FONT" ]; then
            cp "$REGULAR_FONT" "$TERMUX_DIR/font.ttf"
            info "Fonte JetBrains Mono instalada com sucesso!"
        else
            warn "Nao foi possivel localizar a fonte extraida. Coloque font.ttf manualmente em ~/.termux/"
        fi
    else
        warn "Falha ao extrair a fonte. Coloque font.ttf manualmente em ~/.termux/"
    fi
    rm -rf "$FONT_TMP" "$FONT_TMP_DIR"
else
    warn "Falha ao baixar a fonte. Coloque font.ttf manualmente em ~/.termux/"
fi

progress_bar "Gerando scripts do tema" 2

THEMES_DIR="$BASE/themes"
mkdir -p "$THEMES_DIR"
RXFETCH_SH="$THEMES_DIR/banner.sh"

info "Criando banner.sh (estilo macOS)"
cat > "$RXFETCH_SH" <<'EOF'
#!/usr/bin/env bash
# banner.sh - banner minimalista estilo macOS

red="\033[1;31m"
yellow="\033[1;33m"
green="\033[1;32m"
gray="\033[1;90m"
blue="\033[1;34m"
white="\033[1;37m"
reset="\033[0m"

getUser(){ user="$(whoami)"; }
getHost(){ host="$(getprop ro.product.model 2>/dev/null || echo termux)"; }
getDistro(){ os="Android $(getprop ro.build.version.release 2>/dev/null)"; }
getUptime(){ uptime_str="$(uptime --pretty 2>/dev/null | sed 's/up //')"; }
getShellName(){ shell_name="zsh"; }

getUser; getHost; getDistro; getUptime; getShellName

echo -e "\n"
echo -e "  ${red}●${reset} ${yellow}●${reset} ${green}●${reset}   ${white}${user}@${host}${reset}"
echo -e "  ${gray}────────────────────────────────────${reset}"
echo -e "   ${blue}${os}${reset} ${gray}·${reset} ${shell_name} ${gray}·${reset} up ${uptime_str}"
echo -e "\n"
EOF

chmod +x "$RXFETCH_SH"
info "Tema configurado com sucesso!"
