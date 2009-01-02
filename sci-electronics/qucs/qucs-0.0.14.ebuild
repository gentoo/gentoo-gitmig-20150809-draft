# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/qucs/qucs-0.0.14.ebuild,v 1.2 2009/01/02 20:19:10 cryos Exp $

EAPI=1

inherit eutils

DESCRIPTION="Quite Universal Circuit Simulator is a Qt based circuit simulator"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://qucs.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND="x11-libs/qt:3"
RDEPEND="x11-libs/qt:3
	sci-electronics/freehdl"

src_compile() {
	myconf="--with-x $(use_enable debug)"

	econf ${myconf} || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed."

	doicon qucs/bitmaps/big.qucs.xpm
	make_desktop_entry qucs Qucs qucs "Qt;Science;Electronics"
}
