# fnm
export PATH="/home/erickson/.local/share/fnm:$PATH"
source <(fnm completions --shell bash)
eval "$(fnm env --use-on-cd)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# fzf
export FZF_DEFAULT_COMMAND="rg --files"
source /usr/share/doc/fzf/examples/key-bindings.bash   
source /usr/share/bash-completion/completions/fzf
