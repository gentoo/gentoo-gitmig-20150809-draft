# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.94.0.1.ebuild,v 1.1 2004/11/23 20:22:25 vapier Exp $

PATCHVER="1.0"
UCLIBC_PATCHVER="1.0"
inherit toolchain-binutils

KEYWORDS="-*"

src_unpack() {
	toolchain-binutils_src_unpack

	# Patches
	#cd ${WORKDIR}/patch
	#mkdir skip

	apply_binutils_updates
}
