# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/scribus/scribus-1.1.2.ebuild,v 1.2 2003/11/14 13:07:54 hanno Exp $

DESCRIPTION="Desktop Publishing (DTP) and Layout program for Linux."
HOMEPAGE="http://web2.altmuehlnet.de/fschmid/"
SRC_URI="http://web2.altmuehlnet.de/fschmid/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="kde"
S=${WORKDIR}/${P}

DEPEND="=x11-libs/qt-3*
	>=media-libs/freetype-2.1
	>=media-libs/lcms-1.09
	>=media-libs/libart_lgpl-2.3.8
	sys-libs/zlib
	>=sys-devel/gcc-3.0.0
	!media-plugins/scribus-svg
	!media-plugins/scribus-scripting"

src_unpack() {
	unpack ${A}
	# Fix for python-2.3 compatibility (bug #32775)
	sed -e 's:#include "scribus.h":#include <Python.h>\n#include "scribus.h":g' \
	    -i scribus-1.1.2/scribus/plugins/scriptplugin/cmdvar.h
}

src_compile() {
	econf || die
	emake CXXFLAGS="${CXXFLAGS} -I/usr/include/lcms" || die
}

src_install() {
	einstall destdir=${D} || die

	dodoc AUTHORS ChangeLog README TODO

	# Fixing desktop.scribus
	if [ `use kde` ] ; then
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
