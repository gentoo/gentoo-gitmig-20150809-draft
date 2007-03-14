# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/grande-KXL/grande-KXL-0.6.ebuild,v 1.8 2007/03/14 22:36:48 nyhm Exp $

inherit autotools eutils games

DESCRIPTION="ZANAC type game"
HOMEPAGE="http://kxl.orz.hm/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-games/KXL"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-configure.in.patch
	eautoreconf
}

src_install() {
	dodir "${GAMES_STATEDIR}"
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon src/bmp/boss1.bmp ${PN}.bmp
	make_desktop_entry grande Grande /usr/share/pixmaps/${PN}.bmp
	dodoc ChangeLog README
	prepgamesdirs
}
