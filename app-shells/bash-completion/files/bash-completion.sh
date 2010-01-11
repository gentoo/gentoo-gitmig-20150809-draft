# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/files/bash-completion.sh,v 1.8 2010/01/11 17:39:57 darkside Exp $

# Check for interactive bash and that we haven't already been sourced.
[ -z "$BASH_VERSION" -o -z "$PS1" -o -n "$BASH_COMPLETION" ] && return

# Check for recent enough version of bash.
bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
if [ $bmajor -eq 2 -a $bminor '>' 04 ] || [ $bmajor -gt 2 ]; then
    _load_completions() {
    declare f x loaded_pre=false
    for f; do
        if [[ -f $f ]]; then
        # Prevent loading base twice, initially and via glob
        if $loaded_pre && [[ $f == */base ]]; then
            continue
        fi

        # Some modules, including base, depend on the definitions
        # in .pre.  See the ebuild for how this is created.
        if ! $loaded_pre; then
            if [[ ${BASH_COMPLETION-unset} == unset ]]; then
            BASH_COMPLETION="@GENTOO_PORTAGE_EPREFIX@/usr/share/bash-completion/base"
            fi
            source "@GENTOO_PORTAGE_EPREFIX@/usr/share/bash-completion/.pre"
            loaded_pre=true
        fi

        source "$f"
        fi
    done

    # Clean up
    $loaded_pre && source "@GENTOO_PORTAGE_EPREFIX@/usr/share/bash-completion/.post"
    unset -f _load_completions  # not designed to be called more than once
    }

    # 1. Load base, if eselected.  This was previously known as
    #    /etc/bash_completion
    # 2. Load completion modules, maintained via eselect bashcomp --global
    # 3. Load user completion modules, maintained via eselect bashcomp
    # 4. Load user completion file last, overrides modules at user discretion
	# This order is subject to change once upstream decides on something.
    _load_completions \
    "@GENTOO_PORTAGE_EPREFIX@/etc/bash_completion.d/base" \
    ~/.bash_completion.d/base \
    "@GENTOO_PORTAGE_EPREFIX@/etc/bash_completion.d/"* \
    ~/.bash_completion.d/* \
    ~/.bash_completion
fi

unset bash bminor bmajor
