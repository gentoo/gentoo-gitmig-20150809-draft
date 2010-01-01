# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/focuswriter/focuswriter-1.2.0.ebuild,v 1.1 2010/01/01 11:36:55 ssuominen Exp $

EAPI=2
inherit qt4

DESCRIPTION="A fullscreen and distraction-free word processor"
HOMEPAGE="http://gottcode.org/focuswriter/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	app-text/hunspell"

src_prepare() {
	sed -i \
		-e '/PREFIX/s:/usr/local:/usr:' \
		${PN}.pro || die
}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	dodoc ChangeLog README
}
