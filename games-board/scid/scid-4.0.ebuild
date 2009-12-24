# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/scid/scid-4.0.ebuild,v 1.4 2009/12/24 16:28:17 pacho Exp $

EAPI=2
inherit eutils toolchain-funcs games

DESCRIPTION="a free chess database application"
HOMEPAGE="http://scid.sourceforge.net/"
SRC_URI="mirror://sourceforge/scid/${P}.tar.bz2
	mirror://sourceforge/scid/spelling_2009_01.ssp.zip
	mirror://sourceforge/scid/ratings_2009_01.ssp.zip
	mirror://sourceforge/scid/photos2007.zip
	mirror://sourceforge/scid/scidlet40k.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc sparc x86"
IUSE=""

DEPEND=">=dev-lang/tk-8.3
	>=sys-libs/zlib-1.1.3
	app-arch/unzip"
RDEPEND="${DEPEND}
	!games-board/chessdb
	x11-libs/libX11
	>=dev-lang/python-2.1"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		tcl/config.tcl \
		tcl/start.tcl \
		src/scidlet.cpp \
		|| die "sed failed"
	gzip ../ratings_2009_01.ssp
}

src_configure() {
	# configure is not an autotools script
	./configure \
		COMPILE=$(tc-getCXX) \
		LINK=$(tc-getCXX) \
		CC=$(tc-getCC) \
		OPTIMIZE="${CXXFLAGS}" \
		TCL_INCLUDE="" \
		BINDIR="${GAMES_BINDIR}" \
		SHAREDIR="${GAMES_DATADIR}/${PN}" \
		|| die "configure failed"
}

src_compile() {
	emake all_scid || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install_scid || die "emake install failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r sounds || die "failed installing sounds"

	dodoc CHANGES ChangeLog README THANKS TODO
	dohtml help/*.html

	cd ..
	newins spelling_2009_01.ssp spelling.ssp \
		|| die "Failed installing spelling.ssp"
	newins ratings_2009_01.ssp.gz ratings.ssp.gz \
		|| die "Failed installing ratings.ssp"
	doins *.spf \
		|| die "Failed installing photos"
	newins scidlet40k.sbk scidlet.sbk \
		|| die "Failed installing scidlet.sbk"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To enable speech, emerge dev-tcltk/snack"
	elog "To enable some piece sets, emerge dev-tcltk/tkimg"
	elog "To enable Xfcc support, emerge dev-tcltk/tdom"
}
