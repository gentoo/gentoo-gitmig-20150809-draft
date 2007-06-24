# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.2.2.ebuild,v 1.29 2007/06/24 18:14:41 peper Exp $

# This version is really meant JUST for the ps2

MAN_VER=""
PATCH_VER="1.0"
UCLIBC_VER=""
PIE_VER=""
PP_VER=""
HTB_VER=""

ETYPE="gcc-compiler"

SPLIT_SPECS=${SPLIT_SPECS-true}

inherit toolchain eutils

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++ and java compilers"

KEYWORDS=""

src_unpack() {
	gcc_src_unpack

	epatch "${FILESDIR}"/3.2.2/gcc32-pr7768.patch
	epatch "${FILESDIR}"/3.2.2/gcc32-pr8213.patch
	epatch "${FILESDIR}"/3.2.2/gcc-3.2.2-cross-compile.patch
	epatch "${FILESDIR}"/3.2.2/gcc-3.2.2-no-COPYING-cross-compile.patch
}
