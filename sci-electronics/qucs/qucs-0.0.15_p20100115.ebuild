# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/qucs/qucs-0.0.15_p20100115.ebuild,v 1.1 2010/01/15 17:46:42 hwoarang Exp $

EAPI=2
inherit cmake-utils eutils

DESCRIPTION="Quite Universal Circuit Simulator is a Qt based circuit simulator"
HOMEPAGE="http://qucs.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-svg:4"

S=${WORKDIR}/qucs-qt4

DOCS="AUTHORS ChangeLog NEWS PLATFORMS README RELEASE THANKS TODO"

src_prepare() {
	sed -i \
		-e 's/GNOME;Application/Qt:Science;Electronics/' \
		-e '/Encoding/d' \
		debian/qucs.desktop || die
	sed -i \
		-e 's:bitmaps:share/qucs/bitmaps:g' \
		config.h.cmake qucs/bitmaps/CMakeLists.txt || die
}

src_install() {
	cmake-utils_src_install
	doicon qucs/bitmaps/big.qucs.xpm
	domenu debian/qucs.desktop
}
