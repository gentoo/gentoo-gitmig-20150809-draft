# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/colorcode/colorcode-0.5.5.ebuild,v 1.3 2009/12/02 10:54:42 maekke Exp $

EAPI=2
inherit eutils qt4 games

MY_PN=ColorCode

DESCRIPTION="a free advanced MasterMind clone"
HOMEPAGE="http://www.kde-apps.org/content/show.php/ColorCode?content=112702"
SRC_URI="http://test.laebisch.com/${MY_PN}-${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

S=${WORKDIR}/${MY_PN}

pkg_setup() {
	games_pkg_setup
	qt4_pkg_setup
}

src_prepare() {
	sed -i \
		-e '/FLAGS/d' \
		ColorCode.pro \
		|| die "sed failed"
	qt4_src_prepare
}

src_configure() {
	eqmake4 ${MY_PN}.pro
}

src_install() {
	dogamesbin ${MY_PN} || die
	newicon img/cc64.png ${PN}.png
	make_desktop_entry ${MY_PN} ${MY_PN}
	prepgamesdirs
}
