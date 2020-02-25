# zsh/zinit.zsh

export DKO_SOURCE="${DKO_SOURCE} -> zinit.zsh {"

# ----------------------------------------------------------------------------
# Grep / filter
# ----------------------------------------------------------------------------

if ! __dko_has fzf; then
  # Binary release in archive, from GitHub-releases page.
  # After automatic unpacking it provides program "fzf".
  zinit lucid wait from'gh-r' as'program'
  zinit light junegunn/fzf-bin
fi

zinit lucid wait from'gh-r' as'program' mv'fd* -> fd' pick'fd/fd'
zinit light sharkdp/fd

# ----------------------------------------------------------------------------
# Git
# ----------------------------------------------------------------------------

zinit lucid wait as'program' pick for \
  davidosomething/git-ink \
  davidosomething/git-my \
  davidosomething/git-take \
  paulirish/git-open \
  paulirish/git-recent

zinit lucid wait as'program' \
  pick"${ZPFX}/bin/git-*" \
  src'etc/git-extras-completion.zsh' \
  make"PREFIX=${ZPFX}"
zinit light tj/git-extras

# gi is my git-ink alias, and i don't need a .gitignore generator
export forgit_ignore='fgi'
zinit lucid wait
zinit light 'wfxr/forgit'

zinit lucid wait as'program' pick'bin/git-dsf'
zinit light zdharma/zsh-diff-so-fancy

# `` compl for git commands
zinit lucid wait
zinit light 'hschne/fzf-git'

# ----------------------------------------------------------------------------
# Docker
# ----------------------------------------------------------------------------

if __dko_has docker; then
  zinit as'completion'
  zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

  zinit lucid wait from'gh-r' as'program'
  zinit light jesseduffield/lazydocker
fi

# ----------------------------------------------------------------------------
# Misc
# ----------------------------------------------------------------------------

# my fork of cdbk, ZSH hash based directory bookmarking. No wait.
export ZSH_BOOKMARKS="${HOME}/.local/zshbookmarks"
zinit lucid wait
zinit light 'davidosomething/cdbk'

zinit lucid wait from'gh-r' as'program' for \
  mv'bat* -> bat' pick'bat/bat' sharkdp/bat \
  mv'shfmt* -> shfmt' pick'mvdan/sh' mvdan/sh

if __dko_has lua; then
  export _ZL_CMD='j'
  export _ZL_DATA="${XDG_DATA_HOME}/zlua"
  export _ZL_HYPHEN=1
  export _ZL_NO_ALIASES=1
  zinit lucid nocompletions
  #zinit light 'davidosomething/z.lua'
  zinit light 'skywind3000/z.lua'

  # redefine up to work like shannonmoeller/up
  up() {
    number='^[0-9]+$'
    if [[ -z "$1" ]] || [[ "$1" =~ "$number" ]] ; then
      eval "${_ZL_CMD} -b ..${1}"
    else
      eval "${_ZL_CMD} $@"
    fi
  }
else
  zinit lucid wait nocompletions
  zinit light 'shannonmoeller/up'
fi

# ----------------------------------------------------------------------------
# ZSH extensions
# ----------------------------------------------------------------------------

zinit lucid wait'[[ -n ${ZLAST_COMMANDS[(r)man*]} ]]'
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# In-line best history match suggestion
# don't suggest lines longer than
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=78
# as of v4.0 use ZSH/zpty module to async retrieve
#export ZSH_AUTOSUGGEST_USE_ASYNC=1
# Removed forward-char
export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
  vi-end-of-line
  vi-add-eol
)
bindkey '^k' autosuggest-accept
# ! will track the loading since using zinit load
zinit lucid wait atload'!_zsh_autosuggest_start'
zinit load 'zsh-users/zsh-autosuggestions'
# clear the suggestion when entering completion select menu

# ----------------------------------------------------------------------------
# Vendor: Completion
# ----------------------------------------------------------------------------

zinit lucid wait blockf atpull'zinit creinstall -q .'
zinit load 'zsh-users/zsh-completions'

[[ -f "${TRAVIS_CONFIG_PATH}/travis.sh" ]] && {
  zinit lucid wait
  zinit light "$TRAVIS_CONFIG_PATH"
}

# ----------------------------------------------------------------------------
# Syntax last, and compinit before it
# ----------------------------------------------------------------------------

# clear the suggestion when entering completion select menu
zinit lucid wait atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit load 'zsh-users/zsh-completions'

DKO_SOURCE="${DKO_SOURCE} }"
