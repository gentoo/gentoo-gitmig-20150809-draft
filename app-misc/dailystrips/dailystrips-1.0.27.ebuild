# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dailystrips/dailystrips-1.0.27.ebuild,v 1.6 2004/07/14 01:31:01 agriffis Exp $

DESCRIPTION="dailystrips automatically downloads your favorite online comics from the web."
HOMEPAGE="http://dailystrips.sourceforge.net/"
SRC_URI="mirror://sourceforge/dailystrips/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~alpha"
IUSE=""

DEPEND=">=dev-perl/libwww-perl-5.50"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp dailystrips dailystrips.orig
	sed -e "s:/usr/share/dailystrips/strips.def:/etc/strips.def:" \
		dailystrips.orig > dailystrips
}

src_install() {
	dobin dailystrips
	dobin dailystrips-clean
	dodoc README BUGS CHANGELOG TODO

	keepdir /etc
	insinto /etc
	doins strips.def
}
