# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mine"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew osx terminalapp lol git mercurial sublime zsh-syntax-highlighting)

# Emacs
if [[ -n ${INSIDE_EMACS} ]]; then
    ZSH_THEME="mrtazz"
    export TERM=xterm-256color
    export LC_CTYPE=en_AU.UTF-8
fi

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

unsetopt inc_append_history
unsetopt append_history
unsetopt share_history # share command history data

export PATH=/Users/tranma/.gem/ruby/1.8/bin:/Users/tranma/Library/Haskell/bin:/Users/tranma/.cabal/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Users/tranma/Library/Haskell/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/texbin:/Users/tranma/ghc/bin

# Coq
export PATH=$PATH:~/Library/Haskell/bin:/usr/local/cuda/bin:/Applications/CoqIdE_8.4.app/Contents/Resources/bin

# CUDA
#export DYLD_LIBRARY_PATH=/usr/local/cuda/lib

# Set working directory env variables
function chpwd_profiles() {
    local profile context
    local -i reexecute

    context=":chpwd:profiles:$PWD"
    zstyle -s "$context" profile profile || profile='default'
    zstyle -T "$context" re-execute && reexecute=1 || reexecute=0

    if (( ${+parameters[CHPWD_PROFILE]} == 0 )); then
        typeset -g CHPWD_PROFILE
        local CHPWD_PROFILES_INIT=1
        (( ${+functions[chpwd_profiles_init]} )) && chpwd_profiles_init
    elif [[ $profile != $CHPWD_PROFILE ]]; then
        (( ${+functions[chpwd_leave_profile_$CHPWD_PROFILE]} )) \
            && chpwd_leave_profile_${CHPWD_PROFILE}
    fi
    if (( reexecute )) || [[ $profile != $CHPWD_PROFILE ]]; then
        (( ${+functions[chpwd_profile_$profile]} )) && chpwd_profile_${profile}
    fi

    CHPWD_PROFILE="${profile}"
    return 0
}
# Add the chpwd_profiles() function to the list called by chpwd()!
chpwd_functions=( ${chpwd_functions} chpwd_profiles )

# vaultaire
zstyle ':chpwd:profiles:/Users/tranma/dev(|/|/*)' profile vaultaire

chpwd_profile_vaultaire() {
    [[ ${profile} == ${CHPWD_PROFILE} ]] && return 1
    print "chpwd(): Switching to profile: $profile"

    export CABAL_SANDBOX_CONFIG=/Users/tranma/dev/cabal.sandbox.config
}
