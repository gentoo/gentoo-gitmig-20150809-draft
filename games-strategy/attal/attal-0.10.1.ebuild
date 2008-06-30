# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/attal/attal-0.10.1.ebuild,v 1.5 2008/06/30 15:44:09 nyhm Exp $

EAPI=1
inherit eutils qt4 games

MY_P="${PN}-src-${PV}"
DESCRIPTION="turn-based strategy game project"
HOMEPAGE="http://www.attal-thegame.org/"
SRC_URI="mirror://sourceforge/attal/${MY_P}.tar.bz2
	mirror://sourceforge/attal/themes-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="|| (
		( x11-libs/qt-gui:4 x11-libs/qt-qt3support:4 )
		x11-libs/qt:4
	)
	media-libs/libsdl
	media-libs/sdl-mixer"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	QT4_BUILT_WITH_USE_CHECK="qt3support" qt4_pkg_setup
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv ../themes .
	ecvs_clean
	epatch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-gentoo.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		libCommon/displayHelp.cpp \
		libCommon/attalCommon.cpp \
		server/duel.cpp \
		|| die "sed failed"
}

src_compile() {
	eqmake4 Makefile.pro
	emake -j1 || die "emake failed"
}

src_install() {
	dogamesbin attal-* || die "dogamesbin failed"
	dogameslib.so lib*.so* || die "dogameslib.so failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r themes HOWTOPLAY.html || die "doins failed"
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
