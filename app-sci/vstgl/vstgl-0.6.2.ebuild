# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/vstgl/vstgl-0.6.2.ebuild,v 1.1 2004/07/29 11:51:17 chrb Exp $

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
	app-sci/petrify"
	# dev-util/kdoc"

S=${WORKDIR}/${PN}

src_install () {
	einstall INSTALL_ROOT=${D} || die
	dodoc README
	dodir /usr/share/doc/${P}/
	cp -ar examples ${D}/usr/share/doc/${P}/
}
