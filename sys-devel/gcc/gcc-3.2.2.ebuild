# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.2.2.ebuild,v 1.31 2011/07/20 08:58:35 dirtyepic Exp $

# This version is really meant JUST for the ps2

MAN_VER=""
PATCH_VER="1.1"
UCLIBC_VER=""
PIE_VER=""
PP_VER=""
HTB_VER=""

ETYPE="gcc-compiler"

SPLIT_SPECS=${SPLIT_SPECS-true}

inherit toolchain eutils

DESCRIPTION="The GNU Compiler Collection"

KEYWORDS=""
IUSE=""
