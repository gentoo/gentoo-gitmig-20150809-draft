# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/scribus/scribus-1.2.ebuild,v 1.7 2004/11/23 18:31:21 hanno Exp $

inherit kde-functions
need-qt 3

DESCRIPTION="Desktop Publishing (DTP) and Layout program for Linux."
HOMEPAGE="http://www.scribus.net"
SRC_URI="http://www.scribus.org.uk/downloads/${PV}/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc amd64 ~ppc64"
IUSE="kde"

DEPEND=">=x11-libs/qt-3.3.3
	>=media-libs/freetype-2.1
	>=media-libs/lcms-1.09
	media-libs/tiff
	>=media-libs/libart_lgpl-2.3.8
	>=sys-devel/gcc-3.0.0"

RDEPEND="virtual/ghostscript"

src_compile() {
	econf || die
	emake CXXFLAGS="${CXXFLAGS} -I/usr/include/lcms" || die
}

src_install() {
	einstall destdir=${D} || die

	dodoc AUTHORS ChangeLog README TODO

	# Fixing desktop.scribus
	if use kde ; then
		inherit kde-functions
		set-kdedir 3
		sed -e 's/local\///' scribus.desktop > desktop.scribus.2
		echo "Name=Scribus" >> desktop.scribus.2
		cp -f desktop.scribus.2 scribus.desktop
		insinto ${PREFIX}/share/applnk/Graphics
		doins scribus.desktop
	fi

	dosym /usr/share/scribus/doc /usr/share/doc/${PF}/html
}
