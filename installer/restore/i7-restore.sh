#!/usr/bin/env bash
# i7-restore.sh — Gerar script de restauração

BASE="$HOME/SixxTerm"
RESTORE_SH="$HOME/restore.sh"
PREFIX=${PREFIX:-/data/data/com.termux/files/usr}

source "$BASE/lib/progress_bar.sh"

info()    { printf "\e[1;36m[*]\e[0m %s\n" "$1"; }
warn()    { printf "\e[1;33m[!]\e[0m %s\n" "$1"; }
success() { printf "\e[1;32m[✓]\e[0m %s\n" "$1"; }
erro()    { printf "\e[1;31m[✗]\e[0m %s\n" "$1"; }

progress_bar "Preparando módulo de restauração" 2

cat > "$RESTORE_SH" <<'RESTORE_EOF'
#!/usr/bin/env bash
# restore.sh — Restaurar Termux ao estado padrão

PREFIX=${PREFIX:-/data/data/com.termux/files/usr}

info()    { printf "\e[1;36m[*]\e[0m %s\n" "$1"; }
warn()    { printf "\e[1;33m[!]\e[0m %s\n" "$1"; }
success() { printf "\e[1;32m[✓]\e[0m %s\n" "$1"; }

clear
info "Iniciando restauração do Termux..."
sleep 1

# ── Shell padrão ────────────────────────────────────────────────
if [ -x "$PREFIX/bin/bash" ]; then
    chsh -s "$PREFIX/bin/bash" >/dev/null 2>&1 || true
fi

# ── Backup do SixxTerm ──────────────────────────────────────────
if [ -d "$HOME/SixxTerm" ]; then
    BACKUP="$HOME/SixxTerm.bak"
    info "Fazendo backup do SixxTerm → SixxTerm.bak"
    rm -rf "$BACKUP" 2>/dev/null || true
    cp -r "$HOME/SixxTerm" "$BACKUP"
    success "Backup concluído!"
fi

# ── Remover configurações ────────────────────────────────────────
info "Removendo configurações personalizadas..."
rm -rf "$HOME/.zshrc" \
       "$HOME/.zsh_history" \
       "$HOME/.oh-my-zsh" \
       "$HOME/.zlogin" \
       "$HOME/.zprofile" \
       "$HOME/.bashrc" \
       "$HOME/.profile" \
       "$HOME/.bash_profile" \
       "$HOME/.autostart" \
       "$HOME/.aliases" \
       "$HOME/SixxTerm"
success "Configurações removidas!"

# ── Restaurar bash.bashrc padrão ────────────────────────────────
info "Restaurando bash.bashrc padrão..."
mkdir -p "$PREFIX/etc"

cat > "$PREFIX/etc/bash.bashrc" <<'BASHRC'
if [ "$TERM" != "dumb" ]; then
    PS1='~ $ '
fi

echo
echo "Bem-vindo ao Termux!"
echo
echo "Docs:       https://termux.dev/docs"
echo "Comunidade: https://termux.dev/community"
echo
echo "Comandos úteis:"
echo "  pkg search <pacote>"
echo "  pkg install <pacote>"
echo "  pkg upgrade"
echo
BASHRC
success "bash.bashrc restaurado!"

# ── Resetar ~/.termux ────────────────────────────────────────────
info "Resetando ~/.termux..."
rm -rf "$HOME/.termux"
mkdir -p "$HOME/.termux"

cat > "$HOME/.termux/termux.properties" <<'PROP'
extra-keys = [ ['ESC','TAB','CTRL','ALT','UP','DOWN','LEFT','RIGHT'] ]
PROP

termux-reload-settings >/dev/null 2>&1 || true
success "~/.termux resetado!"

# ── Reinstalar pacotes essenciais ────────────────────────────────
info "Reinstalando pacotes essenciais..."
pkg reinstall -y bash coreutils termux-tools >/dev/null 2>&1 || true
success "Pacotes reinstalados!"

# ── Limpar cache ─────────────────────────────────────────────────
info "Limpando cache..."
rm -rf "$PREFIX/var/cache"/* >/dev/null 2>&1 || true
success "Cache limpo!"

# ── Final ────────────────────────────────────────────────────────
success "Termux restaurado ao estado padrão!"
echo -e "\e[1;33mFeche e abra o Termux novamente.\e[0m"
RESTORE_EOF

chmod +x "$RESTORE_SH"
success "Módulo de restauração criado em ~/restore.sh"