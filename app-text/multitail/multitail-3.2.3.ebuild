# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/multitail/multitail-3.2.3.ebuild,v 1.1 2004/07/21 17:47:36 avenj Exp $

DESCRIPTION="Tail with multiple windows."
HOMEPAGE="http://www.vanheusden.com/multitail/index.html"
SRC_URI="http://www.vanheusden.com/multitail/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ia64 ~amd64"

IUSE="debug"
DEPEND="virtual/libc
	sys-libs/ncurses"

src_compile() {
	CFLAGS="${CFLAGS} -D`uname` -DVERSION=\\\"${PV}\\\""
	use debug && CFLAGS="${CFLAGS} -g -D_DEBUG"
	make all CFLAGS="${CFLAGS}" || die "make failed"
}

src_install () {
	dobin multitail
	dodoc Changes INSTALL license.txt readme.txt multitail.conf
	dohtml manual.html
	doman multitail.1
}
