# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ophcrack/ophcrack-3.0.1-r2.ebuild,v 1.1 2008/11/17 17:06:03 ikelos Exp $

inherit toolchain-funcs autotools eutils

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
		>=x11-libs/qt-4"
RDEPEND="dev-libs/openssl
		 net-libs/netwib
		 >=x11-libs/qt-4
		 app-crypt/ophcrack-tables"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-makefile.patch"
	eautoreconf

	rm -fr "${S}/linux_tools"
}

src_install() {
	make install DESTDIR="${D}"

	cd "${S}"
	newicon src/gui/pixmaps/os.xpm ophcrack.xpm
	make_desktop_entry "${PN}" OphCrack ophcrack
}
