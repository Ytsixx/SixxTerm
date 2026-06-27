#!/usr/bin/env bash
# i6-shell.sh — Configuração do Zsh

BASE="$HOME/SixxTerm"
PLUGINS_DIR="$BASE/plugins"
TERMUX_DIR="$HOME/.termux"
ZSHRC="$HOME/.zshrc"

source "$BASE/lib/progress_bar.sh"

info()    { printf "\e[1;36m[*]\e[0m %s\n" "$1"; }
warn()    { printf "\e[1;33m[!]\e[0m %s\n" "$1"; }
success() { printf "\e[1;32m[✓]\e[0m %s\n" "$1"; }
erro()    { printf "\e[1;31m[✗]\e[0m %s\n" "$1"; }

# ── Escrever .zshrc ─────────────────────────────────────────────
progress_bar "Configurando Zsh" 2
cat > "$ZSHRC" <<EOF
# PATH & TERM
clear
export PATH="\$PREFIX/bin:\$HOME/.local/bin:\$PATH"
export TERM=xterm-256color

if [ ! -z "\${ZSH_VERSION-}" ]; then
    autoload -Uz compinit
    compinit
    zstyle ':completion:*' menu select
    bindkey '^\t' expand-or-complete

    if command -v fzf >/dev/null 2>&1; then
        FZF_KEYBINDINGS="\$PREFIX/share/doc/fzf/examples/key-bindings.zsh"
        [ -f "\$FZF_KEYBINDINGS" ] && source "\$FZF_KEYBINDINGS"
    fi

    PLUGINS_DIR="$BASE/plugins"
    [ -d "\$PLUGINS_DIR/zsh-autocomplete" ] && source "\$PLUGINS_DIR/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
    for plugin in zsh-autosuggestions bgnotify zsh-fzf-history-search zsh-syntax-highlighting; do
        [ -d "\$PLUGINS_DIR/\$plugin" ] && source "\$PLUGINS_DIR/\$plugin/\$plugin.zsh" 2>/dev/null || true
    done

    # ── Aliases gerais ───────────────────────────────────────────
    alias c='clear'
    alias q='exit'
    alias sd='cd /sdcard'
    alias dl='cd /sdcard/Download'
    alias pacupg='pkg upgrade'
    alias pacupd='pkg update'
    alias neo='neofetch'
    alias reload='source ~/.zshrc'

    # ── Aliases ficheiros ────────────────────────────────────────
    if command -v logo-ls >/dev/null 2>&1; then
        alias ls='logo-ls'
        alias ll='logo-ls -l'
        alias els='logo-ls'
    else
        alias ls='ls -lh --color=auto'
        alias ll='ls -la --color=auto'
    fi
    alias cp='cp -iv'
    alias mv='mv -iv'
    alias rm='rm -iv'
    alias rmf='rm -rf'
    alias mkdir='mkdir -pv'
    alias mkcd='_(){ mkdir -p "\$1" && cd "\$1"; }; _'
    alias cat='cat -n'
    alias less='less -N'
    alias grep='grep --color=auto'
    alias greph='grep --color=auto -n'
    alias find='find . -name'
    alias size='du -sh'
    alias sizes='du -sh *'
    alias space='df -h'
    alias tree='tree -C'
    alias hidden='ls -la | grep "^\."'
    alias untar='tar -xzvf'
    alias tarc='tar -czvf'
    alias zipp='zip -r'
    alias unzipp='unzip'
    alias backup='cp -r'
    alias count='ls -1 | wc -l'
    alias newest='ls -lt | head'
    alias oldest='ls -lrt | head'

    # ── Aliases Git ──────────────────────────────────────────────
    alias g='git'
    alias gs='git status'
    alias ga='git add .'
    alias gaa='git add --all'
    alias gc='git commit -m'
    alias gca='git commit --amend'
    alias gp='git push'
    alias gpf='git push --force'
    alias gpl='git pull'
    alias gco='git checkout'
    alias gcb='git checkout -b'
    alias gb='git branch'
    alias gbd='git branch -d'
    alias gm='git merge'
    alias gl='git log --oneline --graph --decorate'
    alias gll='git log --oneline --graph --all --decorate'
    alias gd='git diff'
    alias gds='git diff --staged'
    alias grh='git reset --hard'
    alias grs='git reset --soft HEAD~1'
    alias gst='git stash'
    alias gstp='git stash pop'
    alias gclone='git clone'
    alias ginit='git init'

    # ── Aliases pnpm ─────────────────────────────────────────────
    alias p='pnpm'
    alias pi='pnpm install'
    alias pa='pnpm add'
    alias pad='pnpm add -D'
    alias pr='pnpm remove'
    alias prun='pnpm run'
    alias pd='pnpm run dev'
    alias pb='pnpm run build'
    alias ps='pnpm run start'
    alias pt='pnpm run test'
    alias pu='pnpm update'
    alias pug='pnpm update -g'
    alias pig='pnpm install -g'
    alias pl='pnpm list'
    alias plg='pnpm list -g'
    alias pc='pnpm create'
    alias px='pnpm dlx'

    # ── Aliases npm ──────────────────────────────────────────────
    alias ni='npm install'
    alias nia='npm install --save'
    alias nid='npm install --save-dev'
    alias nig='npm install -g'
    alias nr='npm remove'
    alias nrg='npm remove -g'
    alias nrun='npm run'
    alias nd='npm run dev'
    alias nb='npm run build'
    alias ns='npm run start'
    alias nt='npm run test'
    alias nu='npm update'
    alias nug='npm update -g'
    alias nl='npm list'
    alias nlg='npm list -g'
    alias nout='npm outdated'
    alias npub='npm publish'
    alias nx='npx'
    alias ninit='npm init -y'

    # ── Aliases rede ─────────────────────────────────────────────
    alias myip='curl -s ifconfig.me'
    alias myipv6='curl -s ifconfig.me/ip'
    alias localip='ip addr show | grep inet'
    alias ping='ping -c 5'
    alias pingg='ping -c 5 google.com'
    alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3'
    alias ports='netstat -tulanp'
    alias wget='wget -c'
    alias curli='curl -I'
    alias dns='cat /etc/resolv.conf'
    alias netstat='netstat -an'
    alias tracert='traceroute'
    alias myhost='hostname -I'
    alias httpget='curl -O'
    alias headers='curl -sI'

    # ── Aliases Termux ───────────────────────────────────────────
    alias tf='termux-fix-shebang'
    alias tb='termux-battery-status'
    alias tw='termux-wifi-connectioninfo'
    alias tc='termux-clipboard-get'
    alias tcc='termux-clipboard-set'
    alias topen='termux-open'
    alias tshare='termux-share'
    alias tvib='termux-vibrate'

    # ── Aliases Node.js ──────────────────────────────────────────
    alias nv='node -v'
    alias npmv='npm -v'
    alias pnpmv='pnpm -v'
    alias nodemon='nodemon --watch'

    # ── Aliases Python ───────────────────────────────────────────
    alias py='python3'
    alias pip='pip3'
    alias pyv='python3 --version'
    alias pys='python3 -m http.server 8080'
    alias pyc='python3 -c'

    # ── Aliases Sistema ──────────────────────────────────────────
    alias psa='ps aux'
    alias mem='free -h'
    alias cpu='cat /proc/cpuinfo | grep "model name"'
    alias uptime='uptime -p'

    # ── Aliases SSH ──────────────────────────────────────────────
    alias keygen='ssh-keygen -t rsa -b 4096'
    alias pubkey='cat ~/.ssh/id_rsa.pub'
    alias sshconfig='nano ~/.ssh/config'

    # ── Aliases personalizados ───────────────────────────────────
    # Adicione os seus aliases aqui

    PROMPT='%F{white}   ❯_%f '
fi

# ── Banner ───────────────────────────────────────────────────────
BANNER="$BASE/themes/banner.sh"
[ -x "\$BANNER" ] && source "\$BANNER"
EOF
success "Zsh configurado!"

# ── Definir Zsh como shell padrão ───────────────────────────────
progress_bar "Definindo Zsh como shell padrão" 1
ZSH_PATH=$(command -v zsh || true)

if [ -n "$ZSH_PATH" ]; then
    PROFILE="$HOME/.profile"
    grep -q "exec zsh" "$PROFILE" 2>/dev/null || echo "exec zsh" >> "$PROFILE"
    success "Zsh definido como shell padrão!"
    info "Reinicie o Termux para aplicar as mudanças."
else
    erro "Zsh não encontrado. Instale com: pkg install zsh"
    exit 1
fi