# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.16.92.ebuild,v 1.1 2006/04/17 05:59:05 vapier Exp $

PATCHVER="1.0"
UCLIBC_PATCHVER="1.0"
ELF2FLT_VER=""
inherit toolchain-binutils

# ARCH - packages to test before marking
KEYWORDS="-*"

fsrc_unpack() {
	tc-binutils_unpack

	# need to figure out how to make these work ...
	rm \
		"${S}"/binutils/doc/config.texi \
		"${S}"/gas/doc/asconfig.texi \
		"${S}"/ld/configdoc.texi \
		|| die

	tc-binutils_apply_patches
}
