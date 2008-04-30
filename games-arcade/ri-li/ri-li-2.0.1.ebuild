# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ri-li/ri-li-2.0.1.ebuild,v 1.2 2008/04/30 23:36:37 nyhm Exp $

inherit eutils games

DESCRIPTION="Drive a toy wood engine and collect all the coaches"
HOMEPAGE="http://ri-li.sourceforge.net/"
SRC_URI="mirror://sourceforge/ri-li/Ri-li-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer"

S=${WORKDIR}/Ri-li-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}${GAMES_DATADIR}/Ri-li/"*ebuild
	doicon "${D}${GAMES_DATADIR}/Ri-li/"*png
	dodoc AUTHORS ChangeLog NEWS README
	make_desktop_entry Ri_li Ri-li Ri-li-icon-48x48
	prepgamesdirs
}
