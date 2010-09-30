# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qtfm/qtfm-3.1.ebuild,v 1.1 2010/09/30 23:47:13 ssuominen Exp $

EAPI=2
inherit eutils qt4-r2

DESCRIPTION="A lightweight file manager (based on Qt4)"
HOMEPAGE="http://www.wittfella.com/"
SRC_URI="http://www.wittfella.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui:4"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i \
		-e 's:qtfm.png:qtfm:' \
		-e 's:Application;::' \
		qtfm.desktop || die
}

src_install() {
	dobin qtfm || die
	dodoc CHANGELOG README
	domenu qtfm.desktop
	doicon images/qtfm.png
}
