# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/scid/scid-3.6.1.ebuild,v 1.6 2006/12/01 20:59:46 wolf31o2 Exp $

inherit games

DESCRIPTION="a free chess database application"
HOMEPAGE="http://scid.sourceforge.net/"
SRC_URI="mirror://sourceforge/scid/${P}.tar.gz
	http://www.visi.com/~veldy/gentoo/scid-extras-08232002.tar.bz2
	mirror://sourceforge/scid/photos.zip
	mirror://sourceforge/scid/ratings.zip
	mirror://sourceforge/scid/scidlet40k.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-lang/tk-8.3
	>=sys-libs/zlib-1.1.3"
RDEPEND="${DEPEND}
	x11-libs/libX11
	>=dev-lang/python-2.1"
DEPEND="${DEPEND}
	app-arch/unzip"

src_compile() {
	./configure \
		COMPILE=c++ \
		LINK=c++ \
		BINDIR=/usr/bin \
		OPTIMIZE="${CXXFLAGS}" \
		TCL_INCLUDE=""

	# buggy makefiles bug #46110
	emake -j1 || die "emake failed"
}

src_install() {
	dogamesbin pgnfix pgnscid sc_addmove sc_eco sc_epgn sc_import sc_remote \
		sc_spell sc_tree scid scidpgn scmerge spliteco tcscid tkscid scidlet \
			|| die "dogamesbin failed"

	dodoc CHANGES README THANKS
	dohtml help/*.html

	cd "${WORKDIR}"
	insinto "${GAMES_DATADIR}/${PN}"
	doins scidlet40k.sbk gm.spf historic.spf ratings.ssp scid.eco \
		|| die "doins failed"

	prepgamesdirs
}
