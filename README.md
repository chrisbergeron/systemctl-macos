# systemctl-macos

> [!NOTE]
> **This is not a complete replacement of System V for Mac OS.**  This is just a shell script to mangage userspace startup scripts on macos.  The `.plist` files are stored in `$HOME/Library/LaunchAgents`.  This is not comprehensive startup script solution.

This script is just a subset of startup functionality commonly found on Linux and POSIX System V.

## Installation

Just copy the main script `systemctl` to a binary executable directory in your PATH.  For example: `~/bin`, `/opt/homebrew/bin`, `/usr/local/bin`.

## Usage

#### View startup scripts (user)

```bash
$ systemctl list
Available LaunchAgents:
com.chrisbergeron.emporia_to_influx.plist
com.github.domt4.homebrew-autoupdate.plist
homebrew.mxcl.nginx.plist
```

#### View status

```bash
$ systemctl status com.chrisbergeron.emporia_to_influx.plist
```

## Completion scripts

To add tab completion, add these to your `/opt/homebrew/completion.d` directory.

ZSH

```bash
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
```

Bash

```bash
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
```

9937c961-cb04-436a-ac11-2556c5f03c00
