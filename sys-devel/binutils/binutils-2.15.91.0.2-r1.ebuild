# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.91.0.2-r1.ebuild,v 1.3 2005/03/30 17:32:31 kumba Exp $

PATCHVER="1.0"
inherit toolchain-binutils

KEYWORDS="-* -amd64 ~hppa mips ~sparc"

src_unpack() {
	toolchain-binutils_src_unpack

	# Patches
	cd ${WORKDIR}/patch
	mkdir skip
	mv *no_rel_ro* 20_* skip/

	apply_binutils_updates
}
