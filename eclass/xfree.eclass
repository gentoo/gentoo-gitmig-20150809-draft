# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/xfree.eclass,v 1.1 2003/06/29 07:59:35 spyderous Exp $
#
# Author: Seemant Kulleen <seemant@gentoo.org>
#
# The xfree.eclass is designed to ease the checking functions that are
# performed in xfree and xfree-drm ebuilds.  In the new scheme, a variable
# called XFREE_CARDS will be used to indicate which cards a user wishes to
# build support for.  Note, that this variable is only unlocked if the USE
# variable "expertxfree" is switched on

ECLASS=xfree
INHERITED="${INHERITED} ${ECLASS}"

EXPORT_FUNCTIONS xcards


xcards() {
	
	has "$1" "${XFREE_CARDS}" && return 0
	return 1
}
