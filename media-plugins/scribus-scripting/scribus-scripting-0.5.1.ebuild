# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/scribus-scripting/scribus-scripting-0.5.1.ebuild,v 1.1 2003/09/11 13:42:37 hanno Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Python-scripting plugin for Scribus"
HOMEPAGE="http://web2.altmuehlnet.de/fschmid"
SRC_URI="http://web2.altmuehlnet.de/fschmid/${P}.tar.gz"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
DEPEND=">=app-office/scribus-1.1.0"

src_compile() {
	econf || die
	emake CXXFLAGS="${CXXFLAGS} -I/usr/include/lcms" || die
}

src_install () {
	einstall destdir=${D} || die
	dodoc AUTHORS ChangeLog README TODO
}
