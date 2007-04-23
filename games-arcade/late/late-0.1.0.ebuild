# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/late/late-0.1.0.ebuild,v 1.12 2007/04/23 11:48:38 nyhm Exp $

inherit eutils games

DESCRIPTION="A game, similar to Barrack by Ambrosia Software"
HOMEPAGE="http://late.sourceforge.net/"
SRC_URI="mirror://sourceforge/late/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image"

src_unpack() {
	unpack ${A}
	sed -i \
		-e "/chown/d" \
		"${S}"/Makefile.in \
		|| die "sed failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon graphics/latebg2.jpg ${PN}.jpg
	make_desktop_entry late Late /usr/share/pixmaps/${PN}.jpg
	dodoc AUTHORS
	prepgamesdirs
}
