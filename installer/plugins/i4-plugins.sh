#!/usr/bin/env bash
# i4-plugins.sh — Instalar plugins do Zsh

BASE="$HOME/SixxTerm"
PLUGINS_DIR="$BASE/plugins"
source "$BASE/lib/progress_bar.sh"

info()    { printf "\e[1;36m[*]\e[0m %s\n" "$1"; }
warn()    { printf "\e[1;33m[!]\e[0m %s\n" "$1"; }
success() { printf "\e[1;32m[✓]\e[0m %s\n" "$1"; }
erro()    { printf "\e[1;31m[✗]\e[0m %s\n" "$1"; }

# ── Verificar Git ───────────────────────────────────────────────
if ! command -v git >/dev/null 2>&1; then
    warn "Git não encontrado, instalando..."
    pkg install -y git >/dev/null 2>&1 && \
        success "Git instalado!" || \
        { erro "Falha ao instalar Git."; exit 1; }
fi

# ── Plugins ─────────────────────────────────────────────────────
declare -A PLUGINS=(
    [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
    [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    [zsh-autocomplete]="https://github.com/marlonrichert/zsh-autocomplete.git"
    [bgnotify]="https://github.com/t413/zsh-background-notify.git"
    [zsh-fzf-history-search]="https://github.com/joshskidmore/zsh-fzf-history-search.git"
)

mkdir -p "$PLUGINS_DIR"

info "Instalando plugins do Zsh..."

for plugin in "${!PLUGINS[@]}"; do
    dest="$PLUGINS_DIR/$plugin"
    if [ -d "$dest" ]; then
        success "Plugin $plugin já instalado, ignorando...."
    else
        progress_bar "Clonando $plugin" 2
        if git clone --depth=1 "${PLUGINS[$plugin]}" "$dest" >/dev/null 2>&1; then
            success "Plugin $plugin instalado!"
        else
            warn "Falha ao clonar $plugin."
        fi
    fi
done

success "Plugins do Zsh instalados com sucesso!"