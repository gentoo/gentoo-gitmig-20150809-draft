# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libjackasyn/libjackasyn-0.8.ebuild,v 1.1 2003/06/06 22:06:30 robh Exp $

DESCRIPTION="An application/library for connecting OSS apps to Jackit."
HOMEPAGE="http://gige.xdv.org/soft/libjackasyn"
SRC_URI="http://devel.demudi.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/jack"
S=${WORKDIR}/${P}

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
