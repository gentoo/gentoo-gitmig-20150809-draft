# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.94.0.1.ebuild,v 1.2 2004/12/01 02:34:58 vapier Exp $

PATCHVER="1.0"
UCLIBC_PATCHVER="1.0"
inherit toolchain-binutils

KEYWORDS="-*"

src_unpack() {
	toolchain-binutils_src_unpack

	# Patches
	cd ${WORKDIR}/patch
	mkdir skip
	mv 05_* skip

	apply_binutils_updates
}
