# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/kcheckers/kcheckers-0.6.ebuild,v 1.4 2006/08/07 22:07:52 malc Exp $

inherit qt3 games

DESCRIPTION="Qt version of the classic boardgame checkers."
HOMEPAGE="http://kcheckers.org/"
SRC_URI="http://kcheckers.org/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="=x11-libs/qt-3*"

src_compile() {
	sed -i -e 's,/usr/local,/usr,' config.h kcheckers.pro

	${QTDIR}/bin/qmake || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin kcheckers || die "dogamesbin failed"
	dodoc AUTHORS ChangeLog README TODO

	insinto /usr/share/kcheckers
	doins i18n/kcheckers_de.qm i18n/kcheckers_ru.qm kcheckers.pdn

	prepgamesdirs
}
