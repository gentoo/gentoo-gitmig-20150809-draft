# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.16.90.0.3.ebuild,v 1.5 2005/08/27 17:44:15 kumba Exp $

PATCHVER="1.3"
UCLIBC_PATCHVER="1.0"
inherit toolchain-binutils

# ARCH - packages to test before marking
KEYWORDS="-* ~mips"
