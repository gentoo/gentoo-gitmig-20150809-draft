# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.90.0.3-r4.ebuild,v 1.1 2004/12/29 00:30:53 vapier Exp $

PATCHVER="1.4"
UCLIBC_PATCHVER="1.0"
inherit toolchain-binutils

KEYWORDS="-* ~arm ~ppc ~ppc64"

src_unpack() {
	toolchain-binutils_src_unpack
	apply_binutils_updates
}
