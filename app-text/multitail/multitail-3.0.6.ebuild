# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/multitail/multitail-3.0.6.ebuild,v 1.7 2005/01/20 15:39:12 ka0ttic Exp $

DESCRIPTION="Tail with multiple windows."
HOMEPAGE="http://www.vanheusden.com/multitail/index.html"
SRC_URI="http://www.vanheusden.com/multitail/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ia64 amd64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	# tail: '-100lf' option is obsolete; use '-f-n 100' since this will be removed in the future
	sed -i 's/-%dlf/-fn%d/' mt.c || die "sed mt.c failed"
}

src_compile() {
	make all CFLAGS="-D$(uname) ${CFLAGS}" || die "make failed"
}

src_install () {
	dobin multitail
	insinto /etc
	doins multitail.conf
	dodoc Changes INSTALL license.txt readme.txt
	dohtml manual.html
	doman multitail.1
}
