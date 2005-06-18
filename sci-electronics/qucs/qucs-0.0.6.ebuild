# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/qucs/qucs-0.0.6.ebuild,v 1.2 2005/06/18 18:19:29 dholm Exp $

DESCRIPTION="Qt Universal Circuit Simulator is a Qt based circuit simulator"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://qucs.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=x11-libs/qt-3.3.4"

src_compile() {
	econf || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	make install DESTDIR=${D} || die "make install failed."
}
