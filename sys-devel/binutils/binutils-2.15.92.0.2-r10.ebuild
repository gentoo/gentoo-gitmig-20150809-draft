# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.92.0.2-r10.ebuild,v 1.11 2006/01/12 00:42:35 vapier Exp $

PATCHVER="2.7"
UCLIBC_PATCHVER="1.1"
ELF2FLT_VER=""
inherit toolchain-binutils

KEYWORDS="-* alpha amd64 -arm hppa ia64 m68k mips -ppc ~ppc64 sh sparc x86"
