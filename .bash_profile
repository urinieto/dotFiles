# macOS uses zsh by default and throws an annoying warning if you use something else
export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
