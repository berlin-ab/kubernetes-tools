
setup_git() {
    git config --global alias.co checkout
    git config --global alias.st status
    
    export GIT_EDITOR=emacs
}

setup_aliases() {
    alias mini='eval $(minikube docker-env)'

    # navigation
    alias tools='cd ~/workspace/kubernetes-tools'
    alias inf='cd ~/workspace/gp-ci-infrastructure'
    alias ts='cd ~/workspace/gp-toolsmiths/concourse/scripts'
    alias pgci='cd ~/workspace/postgres-for-kubernetes-ci'
    alias pg='cd ~/workspace/postgres-for-kubernetes'
    alias pgp='cd ~/workspace/pg-postgres-release'
    alias sc='cd ~/workspace/state-checker'

    # shorthand binaries
    alias k='/usr/local/bin/kubectl'
    alias h='helm'
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

    export PATH="${PATH}:${HOME}/.krew/bin"
}

setup_bash_completion() {
    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && \
	. "/usr/local/etc/profile.d/bash_completion.sh"
}


__docker_source_name() {
    # if empty string
    if [ -z "$MINIKUBE_ACTIVE_DOCKERD" ]; then
       echo "docker"
    fi

    echo $MINIKUBE_ACTIVE_DOCKERD
}

__active_kubectl_context() {
    local current_context=$(kubectl config current-context)
    # if empty string
    if [ -z "$current_context" ]; then
       echo "no kubectl"
    fi

    echo $current_context
}

setup_docker_prompt() {
    export PROMPT_COMMAND='__git_ps1 "\n (k8s=$(__active_kubectl_context)) \n (docker=$(__docker_source_name)) \n [\u@\h:\w]\n" " \\\$ "'
}

setup_kubebuilder() {
    export PATH=$PATH:/usr/local/kubebuilder/bin
}

setup_direnv() {
    eval "$(direnv hook bash)"
}

setup_postgres_for_kubernetes_ci_tools() {
    export PATH=$PATH:$HOME/workspace/postgres-for-kubernetes-ci/misc
}


main() {
    setup_aliases
    setup_git
    setup_go
    setup_gcloud
    setup_prompt
    setup_kubectl
    setup_kubebuilder
    setup_direnv
    setup_postgres_for_kubernetes_ci_tools
}

main
