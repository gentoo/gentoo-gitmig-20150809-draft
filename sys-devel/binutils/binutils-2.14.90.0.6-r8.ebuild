# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.14.90.0.6-r8.ebuild,v 1.3 2005/04/03 19:17:40 vapier Exp $

PATCHVER="1.0"
UCLIBC_PATCHVER="1.0"
inherit toolchain-binutils

KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 mips ~ppc ~sparc x86"

src_unpack() {
	toolchain-binutils_src_unpack
	apply_binutils_updates
}
