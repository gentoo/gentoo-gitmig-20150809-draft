# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/bash-completion.eclass,v 1.7 2004/12/30 00:18:25 ka0ttic Exp $
#
# Simple eclass that provides an interface for installing
# contributed (ie not included in bash-completion proper)
# bash-completion scripts.
#
# Author: Aaron Walker <ka0ttic@gentoo.org>
# 
# Please assign any bug reports to shell-tools@gentoo.org.

ECLASS="bash-completion"
INHERITED="${INHERITED} ${ECLASS}"
EXPORT_FUNCTIONS pkg_postinst

IUSE="${IUSE} bash-completion"

#RDEPEND="${RDEPEND}
#	bash-completion? ( app-shells/bash-completion-config )"

# dobashcompletion <file> <new file>
#	First arg, <file>, is required and is the location of the bash-completion
# script to install.  Second arg, <new file>, is optional and specifies an
# alternate filename to install as.

dobashcompletion() {
	[[ -z "$1" ]] && die "usage: dobashcompletion <file> <new file>"
	[[ -z "${BASH_COMPLETION_NAME}" ]] && BASH_COMPLETION_NAME="${2:-${PN}}"

	if useq bash-completion ; then
		insinto /usr/share/bash-completion
		newins "$1" "${BASH_COMPLETION_NAME}" || die "Failed to install $1"
	fi
}

bash-completion_pkg_postinst() {
	if useq bash-completion ; then
		echo
		einfo "To enable command-line completion for ${PN}, run:"
		
		# NOTE: this is temporary; bash-completion-config will be in RDEPEND
		# once it goes stable and can be used as a dependency.
		if has_version 'app-shells/bash-completion-config' ; then
			einfo
			einfo "  bash-completion-config --install ${BASH_COMPLETION_NAME}"
			einfo
			einfo "to install locally, or"
			einfo
			einfo "  bash-completion-config --global --install ${BASH_COMPLETION_NAME}"
			einfo
			einfo "to install system-wide."
			einfo "Read bash-completion-config(1) for more information."
		else
			einfo "  ln -s /usr/share/bash-completion/${BASH_COMPLETION_NAME} \\ "
			einfo "    /etc/bash_completion.d/"
		fi
		echo
	fi
}
