# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/moagg/moagg-0.12.ebuild,v 1.1 2004/07/25 11:48:22 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="MOAGG (Mother Of All Gravity Games) combines several different gravity-type games"
HOMEPAGE="http://moagg.sourceforge.net"
SRC_URI="mirror://sourceforge/moagg/${P}-src.tar.bz2
	mirror://sourceforge/moagg/${P}-data.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.6
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-gfx-2.0.8
	>=media-libs/freetype-2.1.4
	>=dev-libs/expat-1.95.6
	>=media-libs/paragui-1.0.4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}-Makefile.in.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO doc/*.tex
	prepgamesdirs
}
