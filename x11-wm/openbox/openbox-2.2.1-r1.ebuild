# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-2.2.1-r1.ebuild,v 1.4 2003/04/23 00:05:16 lostlogic Exp $

IUSE="nls"

inherit commonbox

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox - Development release"
SRC_URI="http://icculus.org/openbox/releases/${P}.tar.gz"
HOMEPAGE="http://icculus.org/openbox/"

SLOT="2"
LICENSE="BSD"
KEYWORDS="~x86 ppc"

MYBIN="${PN}-dev"
mydoc="CHANGE* TODO LICENSE data/README*"
myconf="--enable-xinerama"

src_unpack() {

	unpack ${P}.tar.gz
	sed -i "s:xftlsfonts::" ${S}/util/Makefile.am
	sed -i "s:xftlsfonts::" ${S}/util/Makefile.in

}

src_install() {

	commonbox_src_install

	rm -rf ${D}/usr/share/man/man1/xftlsfont*
	mv ${D}/usr/share/commonbox/openbox/epistrc \
		${D}/usr/share/commonbox/epistrc.default
	rmdir ${D}/usr/share/commonbox/${PN}
	rmdir ${D}/usr/share/commonbox/${MYBIN}

	insinto /usr/share/commonbox/buttons
	doins ${S}/data/buttons/*.xbm

}
