# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/bash-completion.eclass,v 1.8 2005/01/02 11:56:08 ka0ttic Exp $
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

RDEPEND="${RDEPEND}
	bash-completion? ( app-shells/bash-completion-config )"

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
		einfo
		einfo "  bash-completion-config --install ${BASH_COMPLETION_NAME}"
		einfo
		einfo "to install locally, or"
		einfo
		einfo "  bash-completion-config --global --install ${BASH_COMPLETION_NAME}"
		einfo
		einfo "to install system-wide."
		einfo "Read bash-completion-config(1) for more information."
		echo
	fi
}
