# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.16.ebuild,v 1.3 2005/05/17 03:05:30 vapier Exp $

PATCHVER="1.2"
UCLIBC_PATCHVER="1.0"
inherit toolchain-binutils

# ARCH - packages to test before marking
# ia64  - glibc 2.3.5 fails
# ~alpha ~amd64 ~hppa -ia64 ~ppc ~sparc ~x86"
KEYWORDS="-*"
