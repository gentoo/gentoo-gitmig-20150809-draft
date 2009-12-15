# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/karlyriceditor/karlyriceditor-0.7.ebuild,v 1.1 2009/12/15 08:56:22 ssuominen Exp $

EAPI=2
inherit eutils qt4

DESCRIPTION="A program which lets you edit and synchronize lyrics with karaoke songs in varions formats"
HOMEPAGE="http://www.karlyriceditor.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-sound/phonon
	x11-libs/qt-gui:4"

src_configure() {
	eqmake4
}

src_install() {
	dobin bin/${PN} || die
	doicon packages/${PN}.png
	domenu packages/${PN}.desktop
}
