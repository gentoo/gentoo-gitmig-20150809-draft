# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.92.0.2-r5.ebuild,v 1.2 2005/03/09 13:43:47 solar Exp $

PATCHVER="1.6"
UCLIBC_PATCHVER="1.1"
inherit toolchain-binutils

KEYWORDS="-* ~alpha ~amd64 -arm ~hppa -ia64 ~sparc ~x86"

src_unpack() {
	toolchain-binutils_src_unpack

	# Patches
	cd ${WORKDIR}/patch
	mkdir skip
	mv *ldsoconf* *no_rel_ro* 20_* skip/

	apply_binutils_updates
}
