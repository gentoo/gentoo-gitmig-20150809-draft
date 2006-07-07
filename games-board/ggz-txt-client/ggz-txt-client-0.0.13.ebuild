# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-txt-client/ggz-txt-client-0.0.13.ebuild,v 1.2 2006/07/07 21:31:00 wolf31o2 Exp $

inherit games

DESCRIPTION="The textbased client for GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ftp.belnet.be/packages/ggzgamingzone/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="~dev-games/ggz-client-libs-${PV}
	sys-libs/ncurses
	sys-libs/readline"

src_compile() {
	egamesconf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS QuickStart.GGZ README* TODO
	domenu ${D}/usr/share/games/applications/ggz-txt.desktop
	rm -rf ${D}/usr/share/games
	prepgamesdirs
}
