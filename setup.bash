
setup_git() {
    source "$HOME/workspace/kubernetes-tools/git/git-prompt.sh"
    
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUPSTREAM="verbose git name"
    export GIT_PS1_SHOWSTASHSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWCOLORHINTS=true
    
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
    alias vm='cd ~/workspace/tdm-adapter-vagrant-virtual-machine'
    alias pga='cd ~/workspace/tdm-postgres-adapter'

    # shorthand binaries
    alias k='/usr/local/bin/kubectl'
    alias h='helm'

    # colorize ls
    alias ls='ls --color'

    export GIT_TOGETHER_NO_SIGNOFF=1
}

setup_go() {
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
}

setup_gcloud() {
    # check brew info google-cloud-sdk for bash instructions
    # these are zsh specific
    source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
    source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
}

setup_kubectl() {
    # ensure the alias `k` also completes
    #complete -o default -o nospace -F __start_kubectl k

    export PATH="${PATH}:${HOME}/.krew/bin"
}

setup_completion() {
  if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
  fi
}

__docker_source_name() {
    # if empty string
    if [ -z "$MINIKUBE_ACTIVE_DOCKERD" ]; then
       echo "docker"
    fi

    echo $MINIKUBE_ACTIVE_DOCKERD
}

__active_kubectl_context() {
    local current_context=$(kubectl config current-context 2>/dev/null)
    # if empty string
    if [ -z "$current_context" ]; then
       echo "no kubectl"
    fi

    echo $current_context
}

kube_ps1() {
    kubectl config current-context 2>/dev/null
}

setup_prompt() {
    precmd () {
	__git_ps1 "
(kubecontext=$(kube_ps1)) (docker=$(__docker_source_name)) 
(python=[$(python --version)] $(which python | sed s:$PWD:.:))
| %n" " | %~ $ " " | %s"
    }
}

setup_kubebuilder() {
    export PATH=$PATH:/usr/local/kubebuilder/bin
}

setup_direnv() {
    eval "$(direnv hook bash)"
    eval "$(direnv hook zsh)"
}

setup_zsh() {
    #WORDCHARS="*?_-.[]~=/&;!#$%^(){}<>"
    # removed -
    # removed /
    # removed ;
    export WORDCHARS="*?_.[]~=&!#$%^(){}<>"
}

setup_coreutils() {
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/make/libexec/gnubin:$PATH"
}

setup_python() {
    if [ -f ./venv/bin/activate ]; then
	source ./venv/bin/activate
    fi
}


main() {
    setup_python
    setup_direnv
    setup_aliases
    setup_completion
    setup_git
    setup_go
    setup_gcloud
    setup_prompt
    setup_kubectl
    setup_kubebuilder
    setup_coreutils
    setup_zsh
    export EDITOR=emacs
}

main
