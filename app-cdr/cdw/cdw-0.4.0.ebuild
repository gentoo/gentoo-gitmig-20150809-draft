# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdw/cdw-0.4.0.ebuild,v 1.2 2010/07/15 10:50:15 hwoarang Exp $

EAPI=2
inherit autotools eutils

MY_P=${PN}_${PV}
DESCRIPTION="An ncurses based console frontend for cdrtools and dvd+rw-tools"
HOMEPAGE="http://cdw.sourceforge.net"
SRC_URI="mirror://sourceforge/cdw/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/cdrtools
	app-cdr/dvd+rw-tools
	dev-libs/libcdio[-minimal]
	sys-libs/ncurses[unicode]"

S=${WORKDIR}/${MY_P}/cdw

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	rm -f missing
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS THANKS \
		doc/{KNOWN_BUGS,README*,default.conf}
}
