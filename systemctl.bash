_systemctl_complete() {
    local cur prev opts files
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="start stop restart status list enable disable logs"

    if [[ $COMP_CWORD == 1 ]]; then
        COMPREPLY=( $(compgen -W "${opts}" -- "$cur") )
    elif [[ $COMP_CWORD == 2 ]]; then
        files=$(cd ~/Library/LaunchAgents && ls *.plist 2>/dev/null)
        COMPREPLY=( $(compgen -W "${files}" -- "$cur") )
    fi
}
complete -F _systemctl_complete systemctl