# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.91.0.2-r1.ebuild,v 1.5 2005/05/23 00:37:10 vapier Exp $

PATCHVER="1.0"
UCLIBC_PATCHVER=""
inherit toolchain-binutils

KEYWORDS="-* -amd64 ~hppa mips ~sparc"

src_unpack() {
	tc-binutils_unpack

	# Patches
	cd "${WORKDIR}"/patch
	mv *no_rel_ro* 20_* skip/

	tc-binutils_apply_patches
}
