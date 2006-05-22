# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.16.93.ebuild,v 1.1 2006/05/22 04:43:44 vapier Exp $

PATCHVER="1.0"
UCLIBC_PATCHVER="1.0"
ELF2FLT_VER=""
inherit toolchain-binutils

# ARCH - packages to test before marking
KEYWORDS="-*"

src_unpack() {
	tc-binutils_unpack

	# need to figure out how to make these work ...
	rm \
		"${S}"/binutils/doc/config.texi \
		"${S}"/gas/doc/asconfig.texi \
		"${S}"/ld/configdoc.texi \
		|| die

	tc-binutils_apply_patches
}
