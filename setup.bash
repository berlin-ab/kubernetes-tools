#!/usr/bin/env bash


tools_setup_file_path="${BASH_SOURCE[0]}"
tools_directory=$(dirname $tools_setup_file_path)


setup_git() {
    # Source git bash helpers.
    . "${tools_directory}/git/git-prompt.sh"
    . "${tools_directory}/git/git-completion.bash"

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

    alias inf='cd ~/workspace/gp-ci-infrastructure'
    alias ts='cd ~/workspace/gp-toolsmiths/concourse/scripts'
    alias pgci='cd ~/workspace/postgres-for-kubernetes-ci'
    alias pg='cd ~/workspace/postgres-for-kubernetes'
    alias pgp='cd ~/workspace/pg-postgres-release'
    alias sc='cd ~/workspace/state-checker'
    alias k='/usr/local/bin/kubectl'
}

setup_go() {
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
}

setup_gcloud() {
    if [ -f '/Users/adamberlin/workspace/google-cloud-sdk/path.bash.inc' ]; then
	. '/Users/adamberlin/workspace/google-cloud-sdk/path.bash.inc';
    fi
    
    if [ -f '/Users/adamberlin/workspace/google-cloud-sdk/completion.bash.inc' ]; then
	. '/Users/adamberlin/workspace/google-cloud-sdk/completion.bash.inc';
    fi
}

setup_kubectl() {
    # ensure the alias `k` also completes
    complete -o default -o nospace -F __start_kubectl k
}

setup_bash_completion() {
    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
}

main() {
    setup_aliases
    setup_git
    setup_go
    setup_gcloud
    setup_bash_completion
    setup_kubectl
}

main
