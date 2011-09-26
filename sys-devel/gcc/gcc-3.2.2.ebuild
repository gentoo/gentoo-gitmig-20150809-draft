# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.2.2.ebuild,v 1.32 2011/09/26 17:38:49 vapier Exp $

# This version is really meant JUST for the ps2

MAN_VER=""
PATCH_VER="1.1"
UCLIBC_VER=""
PIE_VER=""
PP_VER=""
HTB_VER=""

SPLIT_SPECS=${SPLIT_SPECS-true}

inherit toolchain eutils

DESCRIPTION="The GNU Compiler Collection"

KEYWORDS=""
IUSE=""
