# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.17.ebuild,v 1.15 2006/11/04 11:35:05 vapier Exp $

PATCHVER="1.1"
UCLIBC_PATCHVER="1.0"
ELF2FLT_VER=""
inherit toolchain-binutils

# ARCH - packages to test before marking
KEYWORDS="-* ~amd64 arm ia64 ~mips ppc ~ppc64 sh sparc ~sparc-fbsd ~x86 ~x86-fbsd"
