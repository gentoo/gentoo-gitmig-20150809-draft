# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/grande-KXL/grande-KXL-0.6.ebuild,v 1.11 2011/12/05 09:08:05 mr_bones_ Exp $

inherit autotools eutils games

DESCRIPTION="ZANAC type game"
HOMEPAGE="http://triring.net/ps2linux/games/kxl/kxlgames.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="dev-games/KXL"
RDEPEND="${DEPEND}
	media-fonts/font-adobe-100dpi"

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
