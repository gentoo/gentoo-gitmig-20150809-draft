# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libjackasyn/libjackasyn-0.10.ebuild,v 1.1 2004/01/07 20:35:26 mholzer Exp $

DESCRIPTION="An application/library for connecting OSS apps to Jackit."
HOMEPAGE="http://gige.xdv.org/soft/libjackasyn"
SRC_URI="http://devel.demudi.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/jack
	media-libs/libsamplerate"

S=${WORKDIR}/${P}

src_compile() {
	econf || die
	MAKEOPTS="-j1"
	emake || die
}

src_install() {
	sed -i -e "s:prefix = /usr:prefix = ${D}/usr:" Makefile

	dodir /usr/lib
	dodir /usr/include
	dodir /usr/bin

	emake install || die
	dodoc AUTHORS CHANGELOG WORKING TODO COPYING
}
