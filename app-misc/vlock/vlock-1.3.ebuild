# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vlock/vlock-1.3.ebuild,v 1.11 2004/06/28 04:17:21 vapier Exp $

DESCRIPTION="A console screen locker"
HOMEPAGE="ftp://ftp.ibiblio.org/pub/Linux/utils/console/"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/utils/console/vlock-1.3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	make RPM_OPT_FLAGS="${CFLAGS}" || die
}

src_install() {
	dobin vlock || die
	doman vlock.1
	dodoc README
}
