#!/usr/bin/env bash
# lib/json_format.sh — Formatador inteligente de output do SixxTerm

# ── Detectar e formatar automaticamente ─────────────────────────
_format_output() {
    local input
    input=$(cat)

    # JSON
    if echo "$input" | jq '.' >/dev/null 2>&1; then
        echo "$input" | jq '.'
        return
    fi

    # XML/HTML
    if echo "$input" | xmllint --format - >/dev/null 2>&1; then
        echo "$input" | xmllint --format -
        return
    fi

    # CSV — formata em tabela
    if echo "$input" | grep -qE '^[^,]+,[^,]+'; then
        echo "$input" | awk -F',' '{
            for(i=1; i<=NF; i++) printf "  %-20s", $i
            print ""
        }'
        return
    fi

    # Saída normal
    echo "$input"
}

# ── Wrapper do curl ──────────────────────────────────────────────
curl() {
    local skip=0
    local is_download=0
    local filename=""

    for arg in "$@"; do
        case "$arg" in
            -O)
                is_download=1
                skip=1
                break
                ;;
            -o|--output)
                is_download=1
                skip=1
                break
                ;;
            -I|--head|\
            -T|--upload-file|\
            -v|--verbose|\
            -k|--insecure|\
            -u|--user|\
            -x|--proxy|\
            -C|--continue-at|\
            -f|--fail|\
            --ftp*|--cert*|--cacert*|\
            --progress-bar|--limit-rate*|\
            --retry*|--websocket|\
            --no-buffer|--parallel)
                skip=1
                break
                ;;
        esac
    done

    if [ $is_download -eq 1 ]; then
        # Pega nome do ficheiro da URL
        filename=$(basename "${@: -1}")
        echo -e "\n  \033[1;36m◆\033[0m Baixando \033[1;37m$filename\033[0m\n"

        # Corre curl e captura stats
        local stats
        stats=$(command curl -# -w "\n%{size_download} %{speed_download} %{time_total}" "$@" 2>/dev/null)

        local size speed time
        size=$(echo "$stats" | tail -1 | awk '{printf "%.1fKB", $1/1024}')
        speed=$(echo "$stats" | tail -1 | awk '{printf "%.1fKB/s", $2/1024}')
        time=$(echo "$stats" | tail -1 | awk '{printf "%.1fs", $3}')

        echo -e "  \033[1;32m✔\033[0m Concluído  \033[1;37m$size\033[0m  \033[0;90m$speed  $time\033[0m\n"

    elif [ $skip -eq 1 ]; then
        command curl "$@"
    else
        local output
        output=$(command curl -s "$@")
        echo "$output" | _format_output
    fi
}

# ── Comando manual fmt ───────────────────────────────────────────
fmt() {
    if [ -t 0 ]; then
        echo "$1" | _format_output
    else
        _format_output
    fi
}

# ── Comando cjson — curl + JSON forçado ─────────────────────────
cjson() {
    command curl -s "$@" | jq '.'
}

# ── Extrair campo de JSON ────────────────────────────────────────
jget() {
    local campo="$1"
    shift
    if [ -t 0 ]; then
        echo "$1" | jq -r "$campo"
    else
        jq -r "$campo"
    fi
}