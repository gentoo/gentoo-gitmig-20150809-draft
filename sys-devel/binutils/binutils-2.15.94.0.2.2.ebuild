# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.94.0.2.2.ebuild,v 1.3 2005/03/30 17:32:31 kumba Exp $

PATCHVER="1.1"
UCLIBC_PATCHVER="1.0"
inherit toolchain-binutils

KEYWORDS="-* -arm ~mips"

src_unpack() {
	toolchain-binutils_src_unpack

	# Patches
	#cd ${WORKDIR}/patch
	#mkdir skip

	apply_binutils_updates
}
