#!/bin/sh
CREAM='/usr/share/vim/cream/'
export CREAM
VIMINIT='source /usr/share/vim/cream/.vimrc'
export VIMINIT
exec gvim "$@"
