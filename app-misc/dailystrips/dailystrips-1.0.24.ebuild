# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/dailystrips/dailystrips-1.0.24.ebuild,v 1.4 2002/07/11 06:30:16 drobbins Exp $

DESCRIPTION="dailystrips automatically downloads your favorite online comics from the web."
HOMEPAGE="http://dailystrips.sourceforge.net/"

DEPEND=">=dev-perl/libwww-perl-5.50"

#SRC_URI="mirror://sourceforge/dailystrips/${P}.tar.gz"
SRC_URI="http://west.dl.sourceforge.net/sourceforge/dailystrips/${P}.tar.gz"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	cp dailystrips dailystrips.orig
	sed -e "s:/usr/share/dailystrips/strips.def:/etc/strips.def:" \
		dailystrips.orig > dailystrips
}

src_install() {
	dobin dailystrips
	dodoc README BUGS CHANGELOG TODO

	keepdir /etc
	insinto /etc
	doins strips.def
}
