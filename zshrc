# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# custom aliases
alias ls="eza --icons=always"
alias zsh='vim ~/.zshrc'
alias szsh='source ~/.zshrc'
alias q='exit'
alias s='sudo'
alias v='nvim'
alias g='git'
alias ga='git add'
alias gc='git checkout'
alias gs='git status'
alias gd='git diff'
alias ..='cd ..'
alias cls='clear'
alias nano="vim"
alias tailf="tail -f"
alias lf='ll -p | grep -v /'
alias ldir='ls -ld -- */'
alias edngconf='vim /usr/local/etc/nginx/nginx.conf'
alias cdngconf='cd /usr/local/etc/nginx'
alias bs='brew services'
alias ut='uptime'
alias co='pbcopy'
alias pa='pbpaste'
alias cj='pbpaste | jq'
alias nrd='npm run dev'
alias mk='minikube'
alias mks="minikube start --driver=hyperkit --image-mirror-country='cn'"
alias ck="clickhouse"
alias ssh="TERM=xterm ssh"
alias tar="gtar"

# kubectx
alias kc="kubectx"
alias kn="kubens"

KUBECTX_CURRENT_FGCOLOR=$(tput setaf 6)

# kube-ps1
# https://github.com/jonmosco/kube-ps1
# todo change source path
if [ "$KUBE_PS1_ENABLED" = true ] && kubectl config current-context | grep -q "minikube"; then
    source /usr/local/Cellar/kube-ps1/0.9.0/share/kube-ps1.sh
    PROMPT='$(kube_ps1)'$PROMPT
    KUBE_PS1_PREFIX="["
    KUBE_PS1_SUFFIX="]"
    KUBE_PS1_SYMBOL_ENABLE=false
    KUBE_PS1_CTX_COLOR="83"
    KUBE_PS1_NS_COLOR="201"
fi

# kubectl alias
# load kubectl aliases file
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases

# Print the full command before running it
function kubectl() { echo "+ kubectl $@">&2; command kubectl $@; }

# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=raw-history-view,hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
export HSTR_TIOCSTI=y

# snippet
export PATH=/Users/kuga/snippet:$PATH

# LANG Config
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# homebrew

# nvim
export PATH=/Users/kuga/nvim/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# homebrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
#export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

# mysql
export PATH="/usr/local/opt/mysql@8.4/bin:$PATH"

# Colors
export NAP_PRIMARY_COLOR="#AFBEE1"
export NAP_RED="#A46060"
export NAP_GREEN="#527251"
export NAP_FOREGROUND="7"
export NAP_BACKGROUND="0"
export NAP_BLACK="#373B41"
export NAP_GRAY="240"
export NAP_WHITE="#FFFFFF"

# golang
export GO111MODULE=on
export GOPROXY=https://goproxy.cn
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export PATH=$GOBIN:$PATH

# llvm
export PATH=/usr/local/llvm-15.0.0/bin:$PATH

# the fuck
# fuck () { TF_PYTHONIOENCODING=$PYTHONIOENCODING; export TF_SHELL=zsh; export TF_ALIAS=fuck; TF_SHELL_ALIASES=$(alias); export TF_SHELL_ALIASES; TF_HISTORY="$(fc -ln -10)"; export TF_HISTORY; export PYTHONIOENCODING=utf-8; TF_CMD=$( thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@ ) && eval $TF_CMD; unset TF_HISTORY; export PYTHONIOENCODING=$TF_PYTHONIOENCODING; test -n "$TF_CMD" && print -s $TF_CMD }

# auto suggestion
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# power level 10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# history setup
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# word split
WORDCHARS='_'

# wezterm
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# openresty
PATH=/usr/local/openresty/bin:$PATH

