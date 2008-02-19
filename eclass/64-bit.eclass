# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/64-bit.eclass,v 1.8 2008/02/19 05:15:09 vapier Exp $

# Recognize 64-bit arches...
# Example:
#      64-bit && epatch ${P}-64bit.patch
#

64-bit() {
	die "DO NOT USE THIS ECLASS"

	case "${ARCH}" in
		alpha|*64) return 0 ;;
		*)         return 1 ;;
	esac
}
