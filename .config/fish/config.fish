alias vim="nvim"

set PATH /usr/local/bin $PATH
set PATH node_modules/.bin $PATH
set PATH bin $PATH

abbr gs "git status"
abbr gc "git commit"
abbr gd "git diff"
abbr gdc "git diff --cached"
abbr ga "git add"
abbr gco "git checkout"
abbr gg "git grep"
abbr grh "git reset HEAD"

set -x FZF_DEFAULT_COMMAND 'ag -g ""'

set fish_escape_delay_ms 300

source ~/.config/fish/nvm-wrapper/nvm.fish

fish_vi_key_bindings
