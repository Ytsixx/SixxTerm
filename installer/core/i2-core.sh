
#!/usr/bin/env bash
# i2-core.sh — Instala pacotes essenciais do Termux

BASE="$HOME/SixxTerm"
source "$BASE/lib/progress_bar.sh"

info()    { printf "\e[1;36m[*]\e[0m %s\n" "$1"; }
warn()    { printf "\e[1;33m[!]\e[0m %s\n" "$1"; }
success() { printf "\e[1;32m[✓]\e[0m %s\n" "$1"; }
erro()    { printf "\e[1;31m[✗]\e[0m %s\n" "$1"; }

# ── Atualizar repositórios ──────────────────────────────────────
info "Atualizando repositórios..."
progress_bar "Atualizando repositórios" 2

if apt update -o Acquire::http::Timeout=10 -o Acquire::Retries=1 -qq >/dev/null 2>&1; then
    success "Repositórios atualizados com sucesso!"
else
    warn "Falha ao atualizar repositórios — verifique a sua conexão."
fi

# ── Instalar pacotes essenciais ─────────────────────────────────
PACOTES=(bash coreutils curl git zsh termux-tools unzip jq zip fzf neofetch)
FALTANDO=()

info "Verificando pacotes essenciais..."

for pacote in "${PACOTES[@]}"; do
    if ! dpkg -s "$pacote" &>/dev/null; then
        FALTANDO+=("$pacote")
    fi
done

if (( ${#FALTANDO[@]} == 0 )); then
    success "Todos os pacotes já estão instalados!"
else
    info "Pacotes em falta: ${FALTANDO[*]}"
    info "Instalando pacotes..."

    if pkg install -y --no-upgrade "${FALTANDO[@]}"; then
        success "Pacotes instalados com sucesso!"
    else
        erro "Falha ao instalar pacotes. Tente manualmente: pkg install ${FALTANDO[*]}"
        exit 1
    fi
fi