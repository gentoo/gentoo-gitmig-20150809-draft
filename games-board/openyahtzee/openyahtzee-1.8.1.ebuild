# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/openyahtzee/openyahtzee-1.8.1.ebuild,v 1.2 2008/05/02 10:32:05 maekke Exp $

inherit wxwidgets games

DESCRIPTION="A full-featured wxWidgets version of the classic dice game Yahtzee"
HOMEPAGE="http://openyahtzee.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="=x11-libs/wxGTK-2.8*
	=dev-db/sqlite-3*"

pkg_setup() {
	games_pkg_setup
	WX_GTK_VER=2.8 need-wxwidgets unicode
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s:wx-config:${WX_CONFIG}:" src/Makefile.in || die "sed failed"
}

src_compile() {
	egamesconf --datadir=/usr/share || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog TODO
	prepgamesdirs
}
