# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/mapson/mapson-3.0.ebuild,v 1.7 2009/08/10 08:25:04 ssuominen Exp $

inherit eutils

DESCRIPTION="A challenge/response-based white-list spam filter"
HOMEPAGE="http://mapson.sourceforge.net/"
SRC_URI="mirror://sourceforge/mapson/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="debug"

RDEPEND="virtual/mta"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-gcc43-tests.patch
}

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
	make DESTDIR="${D}" install || die

	cd "${D}"/etc/mapson
	dodoc sample-config
	mv sample-config mapson.config

	cd "${D}"/usr/share/mapson
	dodoc sample-challenge-template
	mv sample-challenge-template challenge-template
	dohtml mapson.html
	rm mapson.html
}
