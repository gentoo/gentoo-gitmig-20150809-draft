# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/multitail/multitail-3.0.6.ebuild,v 1.4 2004/07/01 12:00:07 eradicator Exp $

DESCRIPTION="Tail with multiple windows."
HOMEPAGE="http://www.vanheusden.com/multitail/index.html"
SRC_URI="http://www.vanheusden.com/multitail/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ia64 amd64"

IUSE=""
DEPEND="virtual/libc"

src_compile() {
	make all CFLAGS="-D`uname` ${CFLAGS}" || die "make failed"
}

src_install () {
	dobin multitail
	dodoc Changes INSTALL license.txt readme.txt multitail.conf
	dohtml manual.html
	doman multitail.1
}
