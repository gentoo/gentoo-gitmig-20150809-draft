# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.14.90.0.8-r2.ebuild,v 1.16 2005/03/30 17:32:31 kumba Exp $

PATCHVER="1.4"
UCLIBC_PATCHVER="1.0"
inherit toolchain-binutils

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

src_unpack() {
	toolchain-binutils_src_unpack
	apply_binutils_updates
}
