# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/bash-completion.eclass,v 1.3 2004/10/30 23:13:44 ka0ttic Exp $
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

IUSE="${IUSE} bash-completion"

#RDEPEND="${RDEPEND}
#	bash-completion? ( app-shells/bash-completion )"

# dobashcompletion <file> <new file>
#	First arg, <file>, is required and is the location of the bash-completion
# script to install.  Second arg, <new file>, is optional and specifies an
# alternate filename to install as.

dobashcompletion() {
	[ -z "$1" ] && die "usage: dobashcompletion <file> <new file>"
	if useq bash-completion ; then
		insinto /usr/share/bash-completion
		newins "$1" "${2:-${1##*/}}"
	fi
}
