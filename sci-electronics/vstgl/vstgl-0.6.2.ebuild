# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/vstgl/vstgl-0.6.2.ebuild,v 1.2 2005/08/23 20:43:40 chrb Exp $

inherit eutils

IUSE=""

DESCRIPTION="Visual Signal Transition Graph Lab"
HOMEPAGE="http://vstgl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="x11-libs/qt
	media-libs/libpng
	sys-libs/zlib
	sci-electronics/petrify"
	# dev-util/kdoc"

S=${WORKDIR}/${PN}

src_install () {
	einstall INSTALL_ROOT=${D} || die
	dodoc README
	dodir /usr/share/doc/${P}/
	cp -pPR examples ${D}/usr/share/doc/${P}/
}
