#!/bin/bash
# 
# Preprocessor for 'less'. Used when this environment variable is set:
# LESSOPEN="|lesspipe.sh %s"

trap 'exit 0' PIPE

F=$1	# so we can use "set" later to play with positional params

case "$F" in
  *.tar.bz2) tar tjvvf "$F" 2>/dev/null ;;
  *.tar.gz) tar tzvvf "$F" 2>/dev/null ;;
  *.tar.z) tar tzvvf "$F" 2>/dev/null ;;
  *.tar.Z) tar tzvvf "$F" 2>/dev/null ;;
  *.tar) tar tvvf "$F" 2>/dev/null ;;
  *.tbz2) tar tjvvf "$F" 2>/dev/null ;;
  *.tbz) tar tjvvf "$F" 2>/dev/null ;;
  *.tgz) tar tzvvf "$F" 2>/dev/null ;;
  *.bz2) bzip2 -dc "$F" 2>/dev/null ;;
  *.z) gzip -dc "$F"  2>/dev/null ;;
  *.Z) gzip -dc "$F"  2>/dev/null ;;
  *.zip) unzip -l "$F" 2>/dev/null ;;
  *.rpm) rpm -qilp --changelog "$F" 2>/dev/null ;;
  *.rar) unrar l "$F" 2>/dev/null ;;

  *.[1-9] | *.n | *.man)
  	[[ $(file -L "$F") == *troff* ]] && \
    groff -S -s -p -t -e -Tascii -mandoc "$F" 2>/dev/null ;;

  *.[1-9].gz | *.n.gz | *.man.gz)
  	[[ $(gzip -dc "$F" 2>/dev/null | file -) == *troff* ]] && \
    gzip -dc "$F" 2>/dev/null | groff -S -s -p -t -e -Tascii -mandoc ||
    gzip -dc "$F" 2>/dev/null ;;

  # keep this *after* testing for gzipped troff
  *.gz) gzip -dc "$F"  2>/dev/null ;;

  *)
	set -- $(file -L "$F")
	if [[ $2 == Linux/* || $3 == Linux/* || $2 == ELF || $3 == ELF ]]; then
		strings "$F"
	fi
	;;
esac
