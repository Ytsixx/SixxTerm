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
    local width=$(( term_width / 3 ))
    (( width < 10 )) && width=10

    local delay
    delay=$(awk "BEGIN { printf \"%.4f\", $duracao / 100 }")

    local inicio=$SECONDS

    # Esconde cursor
    printf '\033[?25l'

    local i=0
    while (( i <= 100 )); do
        local step=$(( i * width / 100 ))
        local restante=$(( width - step ))

        local bar="" vazio=""
        (( step > 0 ))     && bar=$(printf '●%.0s' $(seq 1 $step))
        (( restante > 0 )) && vazio=$(printf '○%.0s' $(seq 1 $restante))

        local estimado=$(( duracao - (SECONDS - inicio) ))
        (( estimado < 0 )) && estimado=0

        local spin="${spinners[$spin_idx]}"
        spin_idx=$(( (spin_idx + 1) % ${#spinners[@]} ))

        if (( i == 100 )); then
            # Linha final — um único printf, sem ~Xs e sem spinner
            printf "\r  ${VERDE}✔ %s  %s%s  [ 100%% ]${RESET}\n" \
                "$tarefa" "$bar" "$vazio"
        else
            # Tudo num único printf — evita scroll/duplicação
            printf "\r  ${CIANO}◆${RESET} ${BRANCO}%s${RESET}  %s%s  ${CINZA}[ %3d%% ]  ~%ds  %s${RESET}" \
                "$tarefa" "$bar" "$vazio" "$i" "$estimado" "$spin"
        fi

        sleep "$delay"
        (( i++ ))
    done

    # Mostra cursor novamente
    printf '\033[?25h'
}