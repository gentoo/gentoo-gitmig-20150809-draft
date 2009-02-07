# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ophcrack/ophcrack-3.1.0-r1.ebuild,v 1.1 2009/02/07 18:52:14 ikelos Exp $

inherit eutils

DESCRIPTION="A time-memory-trade-off-cracker"
HOMEPAGE="http://ophcrack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="app-arch/unzip
		>=dev-util/pkgconfig-0.22
		dev-libs/openssl
		net-libs/netwib
		>=x11-libs/qt-gui-4"
RDEPEND="dev-libs/openssl
		 net-libs/netwib
		 >=x11-libs/qt-gui-4
		 app-crypt/ophcrack-tables"

src_install() {
	make install DESTDIR="${D}"

	cd "${S}"
	newicon src/gui/pixmaps/os.xpm ophcrack.xpm
	make_desktop_entry "${PN}" OphCrack ophcrack
}
