_systemctl_complete() {
    local -a commands
    commands=('start' 'stop' 'restart' 'status' 'list' 'enable' 'disable' 'logs')

    if (( CURRENT == 2 )); then
        _describe 'command' commands
    elif (( CURRENT == 3 )); then
        _files -W ~/Library/LaunchAgents -g '*.plist'
    fi
}
compdef _systemctl_complete systemctl