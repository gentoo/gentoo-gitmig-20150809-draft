# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xphotohunter/xphotohunter-1.4.ebuild,v 1.1 2007/05/08 21:35:02 tupone Exp $

inherit eutils games

DESCRIPTION="Find the differences between two pictures."
HOMEPAGE="http://micro.ee.nthu.edu.tw/~tomcat/Xphotohunter/main-english.html"
SRC_URI="http://micro.ee.nthu.edu.tw/~tomcat/Xphotohunter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/imlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i -e "s:@GENTOO_STATEDIR@:${GAMES_STATEDIR}/${PN}:" \
		handler.c || die "Patching state dir failed"
}

src_compile() {
	emake DATADIR="${GAMES_DATADIR}/${PN}" || die "emake failed"
}

src_install() {
	dogamesbin xphotohunter || die "Installing binary failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r Picture *.jpg *.xpm *.bmp *.wav \
		|| die "Installing data files failed"
	insinto "${GAMES_STATEDIR}/${PN}"
	insopts -m0660
	doins ${PN}.dat \
		|| die "Installing data files failed"

	dodoc License.txt README.chinese README.english Rule.txt

	prepgamesdirs
}
