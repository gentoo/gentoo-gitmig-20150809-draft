# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/64-bit.eclass,v 1.4 2004/09/21 12:38:52 kugelfang Exp $

# Recognize 64-bit arches...
# Example:
#      64-bit && epatch ${P}-64bit.patch
# 
64-bit() {
	case "${ARCH}" in 
		alpha|*64) return 0 ;;

		# FIXME: Remove this asap when BUG #55238 is fixed
		#hppa is not 64 bit but needs -fPIC too
		hppa)      return 0 ;;

		*)         return 1 ;;
	esac
}
