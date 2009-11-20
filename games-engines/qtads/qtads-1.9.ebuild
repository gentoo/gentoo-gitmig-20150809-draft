# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/qtads/qtads-1.9.ebuild,v 1.2 2009/11/20 15:17:59 maekke Exp $

EAPI=2
inherit flag-o-matic qt3 games

DESCRIPTION="Qt3-based GUI interpreter for TADS 2 and TADS 3 text adventures"
HOMEPAGE="http://qtads.sourceforge.net/"
SRC_URI="mirror://sourceforge/qtads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="x11-libs/qt:3"

src_prepare() {
	gunzip qtads.6.gz || die "gunzip qtads.6.gz failed"
}

src_configure() {
	# Work-around for a bug when compiling with some versions of g++;
	# strict-aliasing will break the Tads 3 VM.
	append-cxxflags -fno-strict-aliasing
	eqmake3 qtads.pro \
		BIN_INSTALL="${GAMES_BINDIR}" DATA_INSTALL="${GAMES_DATADIR}"
}

src_install() {
	emake INSTALL_ROOT="${D}" install_{target,charmaps,i18n} \
		|| die "emake install failed"
	# install documentation manually to comply with Gentoo guidelines.
	dodoc \
		AUTHORS BUGS CREDITS INSTALL NEWS PORTABILITY README \
		SOURCE_README TIPS TODO
	doman qtads.6
	make_desktop_entry qtads QTads
	prepgamesdirs
}
