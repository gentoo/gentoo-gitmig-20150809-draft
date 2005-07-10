# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/qtads/qtads-1.6c.ebuild,v 1.1 2005/07/10 05:38:56 mr_bones_ Exp $

inherit flag-o-matic games

DESCRIPTION="QT based GUI interpreter for Tads2/Tads3 games"
HOMEPAGE="http://qtads.sourceforge.net/"
SRC_URI="mirror://sourceforge/qtads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="=x11-libs/qt-3*"

src_compile () {
	append-flags -fno-strict-aliasing
	addpredict "${QTDIR}"/etc/settings
	qmake \
		BIN_INSTALL="${GAMES_BINDIR}" \
		DOC_INSTALL=/usr/share/doc/${PF} \
		DATA_INSTALL="${GAMES_DATADIR}" \
		qtads.pro
	emake || die "emake failed"
}

src_install () {
	dogamesbin qtads || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/qtads/charmaps"
	doins charmaps/*.tcp || die "doins failed"
	insinto "${GAMES_DATADIR}/qtads/i18n"
	doins qtads_de.qm || die "doins failed"
	dodoc \
		AUTHORS BUGS CREDITS INSTALL NEWS PORTABILITY README \
		SOURCE_README TIPS TODO
	doman qtads.6.gz
	prepgamesdirs
}
