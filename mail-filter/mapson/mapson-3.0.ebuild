# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/mapson/mapson-3.0.ebuild,v 1.4 2004/11/01 21:21:42 ticho Exp $

DESCRIPTION="A challenge/response-based white-list spam filter"
HOMEPAGE="http://mapson.sourceforge.net/"
SRC_URI="mirror://sourceforge/mapson/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

IUSE="debug"
DEPEND="virtual/libc
	virtual/mta"

src_compile() {
	./configure \
		--build=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/mapson \
		--mandir=/usr/share/man \
		--datadir=/usr/share/mapson \
		`use_with debug` \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	cd ${D}/etc/mapson
	dodoc sample-config
	mv sample-config mapson.config

	cd ${D}/usr/share/mapson
	dodoc sample-challenge-template
	mv sample-challenge-template challenge-template
	dohtml mapson.html
	rm mapson.html
}
