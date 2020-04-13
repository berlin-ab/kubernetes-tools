#!/usr/bin/env bash


tools_setup_file_path="${BASH_SOURCE[0]}"
tools_directory=$(dirname $tools_setup_file_path)


setup_git() {
    # Source git bash helpers.
    . "${tools_directory}/git/git-prompt.sh"
    . "${tools_directory}/git/git-completion.sh"

    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUPSTREAM="verbose git name"
    export GIT_PS1_SHOWSTASHSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWCOLORHINTS=true
    export PROMPT_COMMAND='__git_ps1 "\n[\u@\h:\w]\n" " \\\$ "'    
}

setup_aliases() {
    alias mini="eval $(minikube docker-env)"
    alias tools="cd ${tools_directory}"
}

main() {
    setup_aliases
    setup_git
}

main
