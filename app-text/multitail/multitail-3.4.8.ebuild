# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/multitail/multitail-3.4.8.ebuild,v 1.2 2005/04/09 02:13:27 ka0ttic Exp $

inherit flag-o-matic

DESCRIPTION="Tail with multiple windows."
HOMEPAGE="http://www.vanheusden.com/multitail/index.html"
SRC_URI="http://www.vanheusden.com/multitail/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ia64 ~amd64 ~ppc ~sparc"
IUSE="debug"

DEPEND="virtual/libc
	sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd ${S}
	# tail: '-100lf' option is obsolete; use '-f-n 100'
	# since this will be removed in the future
	sed -i 's/-%dlf/-fn%d/' mt.c || die "sed mt.c failed"
}

src_compile() {
	append-flags "-D$(uname) -DVERSION=\\\"${PV}\\\""
	use debug && append-flags "-g -D_DEBUG"
	make all CFLAGS="${CFLAGS}" || die "make failed"
}

src_install () {
	dobin multitail
	insinto /etc
	doins multitail.conf
	dodoc Changes INSTALL license.txt readme.txt
	dohtml manual.html
	doman multitail.1
}
