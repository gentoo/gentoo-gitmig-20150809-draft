# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vlock/vlock-1.3.ebuild,v 1.8 2004/03/14 10:54:16 mr_bones_ Exp $

DESCRIPTION="A console screen locker"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/utils/console/vlock-1.3.tar.gz"
HOMEPAGE="ftp://ftp.ibiblio.org/pub/Linux/utils/console/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {
	make RPM_OPT_FLAGS="${CFLAGS}" || die
}

src_install() {
	dobin vlock
	doman vlock.1
	dodoc COPYING README
}
