# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.16.1-r2.ebuild,v 1.5 2006/04/25 15:50:31 gustavoz Exp $

PATCHVER="1.9"
UCLIBC_PATCHVER="1.1"
ELF2FLT_VER=""
inherit toolchain-binutils

# ARCH - packages to test before marking
KEYWORDS="-* ~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh sparc ~x86 ~x86-fbsd"
