# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.ebuild,v 1.1 2004/12/04 05:40:14 vapier Exp $

PATCHVER=""
UCLIBC_PATCHVER=""
inherit toolchain-binutils

KEYWORDS="-*"

src_unpack() {
	toolchain-binutils_src_unpack
	apply_binutils_updates
}
