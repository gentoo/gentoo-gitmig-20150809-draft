# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.92.0.2-r6.ebuild,v 1.1 2005/03/11 06:02:03 vapier Exp $

PATCHVER="1.7"
UCLIBC_PATCHVER="1.1"
inherit toolchain-binutils

KEYWORDS="-* ~alpha ~amd64 -arm ~hppa -ia64 ~sparc ~x86"

src_unpack() {
	toolchain-binutils_src_unpack

	# Patches
	cd ${WORKDIR}/patch
	mkdir skip
	#mv 63* skip/

	apply_binutils_updates
}
