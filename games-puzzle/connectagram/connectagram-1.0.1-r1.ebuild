# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/connectagram/connectagram-1.0.1-r1.ebuild,v 1.1 2010/01/13 12:58:54 ssuominen Exp $

EAPI=2
inherit gnome2-utils qt4 games

DESCRIPTION="A word unscrambling game"
HOMEPAGE="http://gottcode.org/connectagram/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

src_prepare() {
	sed -i \
		-e "/PREFIX/s:/usr/local:/usr:" \
		-e "/target.path/s:\$\$PREFIX/bin:${GAMES_BINDIR}:" \
		-e "/definitions.path/s:\$\$PREFIX/share:${GAMES_DATADIR}:" \
		${PN}.pro || die
}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	dodoc ChangeLog
	prepgamesdirs
}

pkg_preinst() {
	gnome2_icon_savelist
	games_pkg_preinst
}

pkg_postinst() {
	gnome2_icon_cache_update
	games_pkg_postinst
}

pkg_postrm() {
	gnome2_icon_cache_update
}
