# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.94.0.2.2.ebuild,v 1.2 2005/03/13 07:52:21 vapier Exp $

PATCHVER="1.1"
UCLIBC_PATCHVER="1.0"
inherit toolchain-binutils

KEYWORDS="-* -arm"

src_unpack() {
	toolchain-binutils_src_unpack

	# Patches
	#cd ${WORKDIR}/patch
	#mkdir skip

	apply_binutils_updates
}
