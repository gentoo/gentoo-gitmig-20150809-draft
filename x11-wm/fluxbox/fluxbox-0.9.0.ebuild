# Copyright 1993-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.9.0.ebuild,v 1.1 2003/04/22 06:45:31 mkeadle Exp $

IUSE="nls"

inherit commonbox flag-o-matic eutils

S=${WORKDIR}/${P}
DESCRIPTION="Windows manager based on Blackbox and pwm - Development Build."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://fluxbox.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

mydoc="ChangeLog COPYING NEWS"
myconf="--enable-xinerama"
#if pkg-config xft
#then
#	CXXFLAGS="${CXXFLAGS} -I/usr/include/freetype2"
#fi
filter-flags -fnoexceptions

src_unpack() {

	unpack ${A}
	cd ${S}
	
}

src_compile() {
	commonbox_src_compile
	
	cd data make \
		pkgdatadir=/usr/share/commonbox init
}

src_install() {
	
	commonbox_src_install
	cd data
	insinto /usr/share/commonbox
	doins init keys
	rmdir ${D}/usr/share/commonbox/fluxbox
	rm -f ${D}/usr/bin/fluxbox-generate_menu
}
