# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/openyahtzee/openyahtzee-1.7.ebuild,v 1.1 2007/05/11 05:38:57 tupone Exp $

inherit eutils games

MY_PN=OpenYahtzee
MY_P=${MY_PN}-${PV}

DESCRIPTION="A full-featured wxWidgets version of the classic dice game Yahtzee"
HOMEPAGE="http://openyahtzee.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.6
	=dev-db/sqlite-3*"

S="${WORKDIR}/${MY_PN}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog TODO
	newicon src/five.xpm ${PN}.xpm
	make_desktop_entry ${PN} "OpenYahtzee" ${PN}.xpm

	prepgamesdirs
}
