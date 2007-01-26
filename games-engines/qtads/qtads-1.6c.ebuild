# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/qtads/qtads-1.6c.ebuild,v 1.4 2007/01/26 08:32:55 vapier Exp $

inherit flag-o-matic qt3 games

DESCRIPTION="QT based GUI interpreter for Tads2/Tads3 games"
HOMEPAGE="http://qtads.sourceforge.net/"
SRC_URI="mirror://sourceforge/qtads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="$(qt_min_version 3)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	gunzip qtads.6.gz || die
}

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
	doman qtads.6
	prepgamesdirs
}
