# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/vlock/vlock-1.3.ebuild,v 1.3 2002/07/25 19:18:35 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A console screen locker"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/utils/console/vlock-1.3.tar.gz"
HOMEPAGE="ftp://ftp.ibiblio.org/pub/Linux/utils/console/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {
	cd ${S}
	make RPM_OPT_FLAGS="${CFLAGS}" || die
}

src_install () {
	cd ${S}
	dobin vlock
	doman vlock.1
	dodoc COPYING README
}
