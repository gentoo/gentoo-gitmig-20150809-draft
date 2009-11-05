# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/videocut/videocut-0.2.0.ebuild,v 1.1 2009/11/05 13:34:48 ssuominen Exp $

EAPI=2
inherit eutils qt4

DESCRIPTION="A program to create compositions from video files"
HOMEPAGE="http://code.google.com/p/videocut/"
SRC_URI="http://videocut.googlecode.com/files/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	media-libs/xine-lib"

S=${WORKDIR}/${P}.orig

src_configure() {
	eqmake4
}

src_compile() {
	emake || die
	lrelease i18n/*.ts
}

src_install() {
	exeinto /usr/libexec
	doexe build/result/${PN} || die
	dobin "${FILESDIR}"/${PN} || die
	insinto /usr/share/${PN}/i18n
	doins -r i18n/*.qm || die
	domenu ${PN}.desktop
	doicon videocut.svg
	dodoc ABOUT AUTHORS THANKSTO
}
