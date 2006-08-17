# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/qtads/qtads-1.6c.ebuild,v 1.3 2006/08/17 02:58:57 mr_bones_ Exp $

inherit flag-o-matic qt3 games

DESCRIPTION="QT based GUI interpreter for Tads2/Tads3 games"
HOMEPAGE="http://qtads.sourceforge.net/"
SRC_URI="mirror://sourceforge/qtads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="$(qt_min_version 3)"

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
