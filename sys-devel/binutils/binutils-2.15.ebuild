# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.ebuild,v 1.9 2006/02/16 04:15:10 vapier Exp $

PATCHVER="1.3"
UCLIBC_PATCHVER=""
ELF2FLT_VER=""
inherit toolchain-binutils

KEYWORDS="-*"

src_unpack() {
	tc-binutils_unpack

	cd "${WORKDIR}"/patch
	# *BSD patches are not safe
	[[ ${CTARGET} != *-freebsd* ]] && mv 00_all_freebsd* skip/
	[[ ${CTARGET} != *-openbsd* ]] && mv 00_all_openbsd* skip/

	tc-binutils_apply_patches
}
