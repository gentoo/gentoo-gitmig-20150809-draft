# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/scribus-scripting/scribus-scripting-0.3.ebuild,v 1.3 2003/07/12 18:40:40 aliz Exp $

S=${WORKDIR}/scriptplugin-${PV}
DESCRIPTION="Python-scripting plugin for Scribus"
HOMEPAGE="http://web2.altmuehlnet.de/fschmid"
SRC_URI="http://web2.altmuehlnet.de/fschmid/scriptplugin-${PV}.tar.gz"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
DEPEND="app-office/scribus"

src_compile() {
	econf || die
	emake CXXFLAGS="${CXXFLAGS} -I/usr/include/lcms" || die
}

src_install () {
	einstall destdir=${D} || die
	dodoc AUTHORS ChangeLog README TODO
}
