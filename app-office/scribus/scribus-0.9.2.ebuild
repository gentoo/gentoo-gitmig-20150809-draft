# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/scribus/scribus-0.9.2.ebuild,v 1.2 2002/11/28 22:17:14 hanno Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scribus is a Layout program"
HOMEPAGE="http://web2.altmuehlnet.de/fschmid"
SRC_URI="http://web2.altmuehlnet.de/fschmid/${P}.tar.gz"
IUSE="kde"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="=x11-libs/qt-3*
	media-libs/freetype
	media-libs/lcms
	sys-libs/zlib"

CXXFLAGS="${CXXFLAGS} -I/usr/include/lcms"

src_compile() {
	econf || die "./configure failed"
	emake || die "make failed"
	mv debian/scribus-debian.xpm debian/scribus.xpm
}

src_install () {

	einstall destdir=${D} || die "couldn't be installed"

	dodoc AUTHORS ChangeLog README TODO

	# Fixing desktop.scribus
	use kde &&
	(
		inherit kde-functions
		set-kdedir 3
		sed -e 's/local\///' desktop.scribus > desktop.scribus.2
		echo "Name=Scribus" >> desktop.scribus.2
		cp -f desktop.scribus.2 scribus.desktop
		insinto ${PREFIX}/share/applnk/Graphics
		doins scribus.desktop
	)
	# Copy the pixmaps to the generic place
	insinto /usr/share/pixmaps/
	doins debian/scribus.xpm

	dosym /usr/share/scribus/doc /usr/share/doc/${PF}/html

}
