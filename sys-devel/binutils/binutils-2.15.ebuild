# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.ebuild,v 1.2 2005/01/03 00:00:16 ciaranm Exp $

PATCHVER=""
UCLIBC_PATCHVER=""
inherit toolchain-binutils

KEYWORDS="-*"

src_unpack() {
	toolchain-binutils_src_unpack
	apply_binutils_updates
}
