# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.92.0.2-r8.ebuild,v 1.2 2005/04/09 13:10:19 corsair Exp $

PATCHVER="2.1"
UCLIBC_PATCHVER="1.1"
inherit toolchain-binutils

KEYWORDS="-* ~alpha ~amd64 -arm ~hppa ~ia64 ~sparc ~x86 ~ppc64"

src_unpack() {
	toolchain-binutils_src_unpack

	# Patches
	cd ${WORKDIR}/patch
	mkdir skip
	#mv 63* skip/

	apply_binutils_updates
}
