# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/scribus/scribus-0.8.ebuild,v 1.8 2003/08/23 23:31:25 lanius Exp $

DESCRIPTION="Layout program similar to Adobe(R) PageMaker, QuarkXPress, or Adobe(R) InDesign"
HOMEPAGE="http://web2.altmuehlnet.de/fschmid/"
SRC_URI="http://web2.altmuehlnet.de/fschmid/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="kde"

DEPEND="=x11-libs/qt-3*
	media-libs/freetype
	media-libs/lcms
	sys-libs/zlib"

CXXFLAGS="${CXXFLAGS} -I/usr/include/lcms"

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/Fonts.diff
	patch -p0 < ${FILESDIR}/Palette.diff
}

src_compile() {
	econf || die
	emake || die "make failed"
	mv debian/scribus-debian.xpm debian/scribus.xpm
}

src_install() {
	einstall destdir=${D}

	dodoc AUTHORS ChangeLog README TODO

	# Fixing desktop.scribus
	if [ `use kde` ] ; then
		inherit kde-functions
		set-kdedir 3
		sed -e 's/local\///' desktop.scribus > desktop.scribus.2
		echo "Name=Scribus" >> desktop.scribus.2
		cp -f desktop.scribus.2 scribus.desktop
		insinto ${PREFIX}/share/applnk/Graphics
		doins scribus.desktop
	fi
	# Copy the pixmaps to the generic place
	insinto /usr/share/pixmaps/
	doins debian/scribus.xpm

	dosym /usr/share/scribus/doc /usr/share/doc/${PF}/html
}
