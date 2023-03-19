#!/bin/bash
#SCRIPT_PATH=$(dirname "$0")
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH"/port.sh

function setup() {
    mkdir -p ~/.vscode_term_connections
    export VSCODE_EXEC=$(\which code)
    env | \grep VSCODE >~/.vscode_term_connections/$1
}

function c() {
    if [ $(isRemote) ]; then
        _remote=$(get_remote)
        _file=~/.vscode_term_connections/$_remote
        [[ -f $_file ]] && _prefix=$(cat $_file | xargs)
        _export_cmd="export $_prefix"
        $(
            $_export_cmd
            $VSCODE_EXEC $@
        )
    else
        code $@
    fi
}

alias e=c

if [ $(isRemote) ]; then
    if [[ "$TERM_PROGRAM" == "vscode" ]]; then
        setup $(get_remote)
    fi
fi
