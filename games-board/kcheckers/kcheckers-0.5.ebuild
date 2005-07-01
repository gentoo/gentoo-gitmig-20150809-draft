# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/kcheckers/kcheckers-0.5.ebuild,v 1.4 2005/07/01 15:02:50 caleb Exp $

inherit kde games

DESCRIPTION="Qt version of the classic boardgame checkers."
HOMEPAGE="http://kcheckers.osdn.org.ua/"
SRC_URI="http://kcheckers.osdn.org.ua/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="virtual/x11
	>=x11-libs/qt-3.3.2"

src_compile() {
	kde_src_compile nothing
	${QTDIR}/bin/qmake
	emake || die "emake failed"
}

src_install() {
	dogamesbin kcheckers || die "dogamesbin failed"
	dodoc AUTHORS README TODO ChangeLog
	prepgamesdirs
}
