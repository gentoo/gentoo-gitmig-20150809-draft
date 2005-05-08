# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/bash-completion.eclass,v 1.11 2005/05/08 01:35:58 ka0ttic Exp $
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
# script to install.  If the variable BASH_COMPLETION_NAME is set in the
# ebuild, dobashcompletion will install <file> as
# /usr/share/bash-completion/$BASH_COMPLETION_NAME. If it is not set,
# dobashcompletion will check if a second arg ($2) was passed, installing as
# the specified name.  Failing both these checks, dobashcompletion will
# install the file as /usr/share/bash-completion/${PN}.

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
		if has_version app-admin/eclectic ; then
			einfo "  eclectic bashcomp enable ${BASH_COMPLETION_NAME:-${PN}}"
		else
			einfo "  bash-completion-config --install ${BASH_COMPLETION_NAME:-${PN}}"
			einfo
			einfo "to install locally, or"
			einfo
			einfo "  bash-completion-config --global --install ${BASH_COMPLETION_NAME:-${PN}}"
			einfo
			einfo "to install system-wide."
			einfo "Read bash-completion-config(1) for more information."
		fi
		echo
	fi
}
