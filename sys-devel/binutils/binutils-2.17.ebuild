# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.17.ebuild,v 1.7 2006/07/05 00:23:34 gustavoz Exp $

PATCHVER="1.0"
UCLIBC_PATCHVER="1.0"
ELF2FLT_VER=""
inherit toolchain-binutils

# ARCH - packages to test before marking
KEYWORDS="-* ~amd64 ~arm ~ppc ~ppc64 ~sh ~x86 ~x86-fbsd"
