# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/64-bit.eclass,v 1.2 2003/12/21 23:27:59 gmsoft Exp $

# Recognize 64-bit arches... This is to help when adding -fPIC, for
# example:
#
# 		64-bit && append-flags -fPIC
# 
64-bit() {
	case "${ARCH}" in 
		alpha|*64) return 0 ;;

		#hppa is not 64 bit but needs -fPIC too
		hppa)      return 0 ;;

		*)         return 1 ;;
	esac
}
