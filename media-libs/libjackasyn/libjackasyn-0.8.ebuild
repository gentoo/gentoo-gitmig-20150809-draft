# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libjackasyn/libjackasyn-0.8.ebuild,v 1.7 2004/06/24 23:10:44 agriffis Exp $

DESCRIPTION="An application/library for connecting OSS apps to Jackit."
HOMEPAGE="http://gige.xdv.org/soft/libjackasyn"
SRC_URI="http://devel.demudi.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND="media-sound/jack-audio-connection-kit"
IUSE=""

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i "s%#include <jack/error.h>%%" libjackasyn.c
}

src_compile() {
	econf || die
	# This package doesnt seem to like emake
	make || die
}

src_install() {
	cp Makefile Makefile~
	sed -e "s:prefix = /usr:prefix = ${D}/usr:" Makefile~ > Makefile

	dodir /usr/lib
	dodir /usr/include
	dodir /usr/bin

	emake install || die
	dodoc AUTHORS CHANGELOG WORKING TODO COPYING
}
