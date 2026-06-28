#!/usr/bin/env bash
# i3-extra.sh — Instalar utilitários extra (Go, logo-ls)

BASE="$HOME/SixxTerm"
PLUGINS_DIR="$BASE/plugins"
TERMUX_DIR="$HOME/.termux"
LOGOLS_DIR="$HOME/.cache/SixxTerm/logo-ls"

source "$BASE/lib/progress_bar.sh"

info()    { printf "\e[1;36m[*]\e[0m %s\n" "$1"; }
warn()    { printf "\e[1;33m[!]\e[0m %s\n" "$1"; }
success() { printf "\e[1;32m[✓]\e[0m %s\n" "$1"; }
erro()    { printf "\e[1;31m[✗]\e[0m %s\n" "$1"; }

# ── Instalar Go ─────────────────────────────────────────────────
info "Verificando Go..."
if ! command -v go >/dev/null 2>&1; then
    progress_bar "Instalando Go" 3
    if pkg install -y golang >/dev/null 2>&1; then
        success "Go instalado com sucesso!"
    else
        erro "Falha ao instalar Go."
        exit 1
    fi
else
    success "Go já está instalado!"
fi

# ── Clonar ou atualizar logo-ls ─────────────────────────────────
info "Verificando logo-ls..."
if [ -d "$LOGOLS_DIR" ]; then
    progress_bar "Atualizando logo-ls" 2
    if git -C "$LOGOLS_DIR" pull --quiet >/dev/null 2>&1; then
        success "logo-ls atualizado!"
    else
        warn "Falha ao atualizar logo-ls."
    fi
else
    progress_bar "Clonando logo-ls" 3
    if git clone --quiet https://github.com/Yash-Handa/logo-ls.git "$LOGOLS_DIR" >/dev/null 2>&1; then
        success "logo-ls clonado com sucesso!"
    else
        erro "Falha ao clonar logo-ls."
        exit 1
    fi
fi

# ── Compilar logo-ls ────────────────────────────────────────────
cd "$LOGOLS_DIR" || exit 1
progress_bar "Compilando logo-ls" 4
if go build -o "$PREFIX/bin/logo-ls" >/dev/null 2>&1; then
    chmod +x "$PREFIX/bin/logo-ls"
    success "logo-ls instalado com sucesso!"
else
    erro "Falha na compilação. Verifique a instalação do Go."
    exit 1
fi

# ── Aliases ─────────────────────────────────────────────────────
ZSHRC="$HOME/.zshrc"
if ! grep -q "alias ls='logo-ls'" "$ZSHRC" 2>/dev/null; then
    info "Adicionando aliases ao .zshrc..."
    {
        echo "alias ls='logo-ls'"
        echo "alias els='logo-ls'"
    } >> "$ZSHRC"
    success "Aliases adicionados!"
else
    success "Aliases já existem no .zshrc!"
fi

# ── Criar estrutura de pastas ───────────────────────────────────
progress_bar "Criando pastas" 1
mkdir -p "$PLUGINS_DIR" "$TERMUX_DIR"

success "Utilitários extra instalados com sucesso!"