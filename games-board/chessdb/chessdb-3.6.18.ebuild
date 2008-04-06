# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/chessdb/chessdb-3.6.18.ebuild,v 1.3 2008/04/06 00:02:53 nyhm Exp $

inherit toolchain-funcs eutils games

MY_PN=ChessDB
MY_P=${MY_PN}-${PV}
DESCRIPTION="A free Chess Database"
HOMEPAGE="http://chessdb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	tb4? ( mirror://sourceforge/${PN}/4-piece-tablebases.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tb4"

RDEPEND="!games-board/scid
	dev-lang/tk"
DEPEND="${RDEPEND}
	tb4? ( app-arch/unzip )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		-e "s:@snack_path@:/usr/lib/snack2.2:" \
		tcl/start.tcl || die "sed failed"
}

src_compile() {
	./configure \
		BINDIR="${GAMES_BINDIR}" \
		COMPILE="$(tc-getCXX)" \
		CC="$(tc-getCC)" \
		LINK="$(tc-getCXX)" \
		OPTIMIZE="${CXXFLAGS}" \
		SHAREDIR="${GAMES_DATADIR}/${PN}" \
		SOUNDSDIR="${GAMES_DATADIR}/${PN}/sounds" \
		TBDIR="${GAMES_DATADIR}/${PN}/tablebases" \
		MANDIR="/usr/share/man" \
		WARNINGS="" || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use tb4; then
		insinto "${GAMES_DATADIR}/${PN}"/tablebases
		doins ../*.emd || die "doins failed"
	fi

	dodoc BUGS CONTRIBUTORS ChangeLog NEWS README THANKS THANKS.Shane TODO
	dohtml -r html-help/*

	doicon ${PN}.ico
	make_desktop_entry ${PN} ChessDB /usr/share/pixmaps/${PN}.ico

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To enable speech, just emerge dev-tcltk/snack"
}
