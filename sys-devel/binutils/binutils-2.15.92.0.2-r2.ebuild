# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.92.0.2-r2.ebuild,v 1.8 2004/11/23 16:55:48 vapier Exp $

PATCHVER="1.2"
UCLIBC_PATCHVER="1.1"
inherit toolchain-binutils

KEYWORDS="-*"

src_unpack() {
	toolchain-binutils_src_unpack

	# Patches
	cd ${WORKDIR}/patch
	mkdir skip
	if use uclibc ; then
		mv *relro* skip/
	else
		mv *no_rel_ro* 20_* skip/
	fi
	mv *ldsoconf* skip/

	apply_binutils_updates
}
