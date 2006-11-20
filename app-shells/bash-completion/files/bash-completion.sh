# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/files/bash-completion.sh,v 1.1 2006/11/20 23:06:15 agriffis Exp $
#
# START bash completion -- do not remove this line

# Need interactive bash with complete builtin
if [ -n "$PS1" -a -n "$BASH_VERSION" -a \
    "`type -t complete 2>/dev/null`" = builtin ]
then
    _load_completions() {
	declare f x loaded_pre=false
	for f; do
	    if [[ -f $f ]]; then
		# Some modules, including default, depend on the definitions
		# in .pre.  See the ebuild for how this is created.
		if ! $loaded_pre; then
		    BASH_COMPLETION=/usr/share/bash-completion/base
		    source /usr/share/bash-completion/.pre
		    loaded_pre=true
		fi
		source "$f"
	    fi
	done

	# Clean up
	$loaded_pre && source /usr/share/bash-completion/.post
	unset -f _load_completions
    }

    # 1. Load defaults, if eselected.  This was previously known as
    #    /etc/bash_completion
    # 2. Load completion modules, maintained via eselect bashcomp --global
    # 3. Load user completion modules, maintained via eselect bashcomp
    # 4. Load user completion file last, overrides modules at user discretion
    _load_completions \
	/etc/bash_completion.d/default \
	~/.bash_completion.d/default \
	/etc/bash_completion.d/* \
	~/.bash_completion.d/* \
	~/.bash_completion
fi

# END bash completion -- do not remove this line
