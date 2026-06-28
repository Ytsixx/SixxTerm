#!/usr/bin/env bash
# i4-plugins.sh — Instalar plugins do Zsh

BASE="$HOME/SixxTerm"
PLUGINS_DIR="$BASE/plugins"
source "$BASE/lib/progress_bar.sh"

info()    { printf "\e[1;36m[*]\e[0m %s\n" "$1"; }
warn()    { printf "\e[1;33m[!]\e[0m %s\n" "$1"; }
success() { printf "\e[1;32m[✓]\e[0m %s\n" "$1"; }
erro()    { printf "\e[1;31m[✗]\e[0m %s\n" "$1"; }

# ── Verificar Git ────────────────────────────────────────────────
if ! command -v git >/dev/null 2>&1; then
    warn "Git não encontrado, instalando..."
    pkg install -y git >/dev/null 2>&1 && \
        success "Git instalado!" || \
        { erro "Falha ao instalar Git."; exit 1; }
fi

# ── Plugins ──────────────────────────────────────────────────────
declare -A PLUGINS=(
    [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
    [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    [zsh-autocomplete]="https://github.com/marlonrichert/zsh-autocomplete.git"
    [bgnotify]="https://github.com/t413/zsh-background-notify.git"
    [zsh-fzf-history-search]="https://github.com/joshskidmore/zsh-fzf-history-search.git"
)

# Ficheiro principal de cada plugin
declare -A PLUGIN_FILE=(
    [zsh-autosuggestions]="zsh-autosuggestions.zsh"
    [zsh-syntax-highlighting]="zsh-syntax-highlighting.zsh"
    [zsh-autocomplete]="zsh-autocomplete.plugin.zsh"
    [bgnotify]="bgnotify.plugin.zsh"
    [zsh-fzf-history-search]="zsh-fzf-history-search.plugin.zsh"
)

mkdir -p "$PLUGINS_DIR"

info "Verificando plugins do Zsh..."

for plugin in "${!PLUGINS[@]}"; do
    dest="$PLUGINS_DIR/$plugin"
    ficheiro="$dest/${PLUGIN_FILE[$plugin]}"

    if [ -d "$dest" ] && [ -f "$ficheiro" ]; then
        success "Plugin $plugin já instalado!"
    else
        # Pasta existe mas ficheiro principal não — reinstala
        [ -d "$dest" ] && rm -rf "$dest"
        progress_bar "Clonando $plugin" 2
        if git clone --depth=1 "${PLUGINS[$plugin]}" "$dest" >/dev/null 2>&1; then
            success "Plugin $plugin instalado!"
        else
            warn "Falha ao clonar $plugin."
        fi
    fi
done

success "Plugins do Zsh prontos!"