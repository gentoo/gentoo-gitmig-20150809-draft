# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/late/late-0.1.0.ebuild,v 1.10 2005/08/09 21:15:42 mr_bones_ Exp $

inherit games

DESCRIPTION="A game, similar to Barrack by Ambrosia Software"
HOMEPAGE="http://late.sourceforge.net/"
SRC_URI="mirror://sourceforge/late/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.8
	media-libs/sdl-image"

src_unpack() {
	unpack ${A}
	sed -i \
		-e "/chown/d" \
		"${S}"/Makefile.in \
		|| die "sed failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS
	prepgamesdirs
}
