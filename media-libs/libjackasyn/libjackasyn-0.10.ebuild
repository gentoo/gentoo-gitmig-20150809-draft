# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libjackasyn/libjackasyn-0.10.ebuild,v 1.7 2004/09/01 17:11:58 eradicator Exp $

DESCRIPTION="An application/library for connecting OSS apps to Jackit."
HOMEPAGE="http://gige.xdv.org/soft/libjackasyn"
SRC_URI="http://devel.demudi.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
DEPEND="media-sound/jack-audio-connection-kit
	media-libs/libsamplerate"

IUSE=""

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	sed -i -e "s:prefix = /usr:prefix = ${D}/usr:" Makefile

	dodir /usr/lib
	dodir /usr/include
	dodir /usr/bin

	emake install || die
	dodoc AUTHORS CHANGELOG WORKING TODO COPYING
}
