progress_bar() {
    local tarefa="$1"
    local duracao="${2:-2}"

    local CIANO=$'\033[1;36m'
    local BRANCO=$'\033[1;37m'
    local CINZA=$'\033[0;90m'
    local VERDE=$'\033[1;32m'
    local RESET=$'\033[0m'

    local spinners=(⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏)
    local spin_idx=0

    local term_width
    term_width=$(tput cols 2>/dev/null || echo 80)

    local reservado=$(( 4 + ${#tarefa} + 26 ))
    local width=$(( term_width - reservado ))
    (( width < 6 )) && width=6
    (( width > 30 )) && width=30

    local delay
    delay=$(awk "BEGIN { printf \"%.4f\", $duracao / 100 }")

    # Tempo de início em milissegundos
    local inicio_ms
    inicio_ms=$(date +%s%3N)
    local duracao_ms=$(( duracao * 1000 ))

    printf '\033[?25l'

    local i=0
    while (( i <= 100 )); do
        local step=$(( i * width / 100 ))
        local restante=$(( width - step ))

        local bar="" vazio=""
        (( step > 0 ))     && bar=$(printf '●%.0s' $(seq 1 $step))
        (( restante > 0 )) && vazio=$(printf '○%.0s' $(seq 1 $restante))

        # Tempo decorrido e estimado em ms → converte pra segundos com 1 casa
        local agora_ms
        agora_ms=$(date +%s%3N)
        local decorrido_ms=$(( agora_ms - inicio_ms ))
        local restante_ms=$(( duracao_ms - decorrido_ms ))
        (( restante_ms < 0 )) && restante_ms=0
        local estimado
        estimado=$(awk "BEGIN { printf \"%.1f\", $restante_ms / 1000 }")

        local spin="${spinners[$spin_idx]}"
        spin_idx=$(( (spin_idx + 1) % ${#spinners[@]} ))

        if (( i == 100 )); then
            printf "\r  ${VERDE}✔ %s  %s%s  [ 100%% ]${RESET}\n" \
                "$tarefa" "$bar" "$vazio"
        else
            printf "\r  ${CIANO}◆${RESET} ${BRANCO}%s${RESET}  %s%s  ${CINZA}[ %3d%% ]  ~%ss  %s${RESET}" \
                "$tarefa" "$bar" "$vazio" "$i" "$estimado" "$spin"
        fi

        sleep "$delay"
        (( i++ ))
    done

    printf '\033[?25h'
}