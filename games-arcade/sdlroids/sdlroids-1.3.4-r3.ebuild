# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdlroids/sdlroids-1.3.4-r3.ebuild,v 1.1 2004/01/24 13:12:12 mr_bones_ Exp $

inherit games

DESCRIPTION="Asteroids Clone for X using SDL"
HOMEPAGE="http://david.hedbor.org/projects/sdlroids/"
SRC_URI="mirror://sourceforge/sdlroids/${P}.tar.bz2"

RESTRICT="nomirror"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.8
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	sed -i \
		-e 's/$(SOUNDSDIR)/$(DESTDIR)$(SOUNDSDIR)/' \
		-e 's/$(GFXDIR)/$(DESTDIR)$(GFXDIR)/' ${S}/Makefile.in \
			|| die "sed Makefile.in failed"
}

src_install () {
	make DESTDIR="${D}" install   || die "make install failed"
	dodoc ChangeLog README.* TODO || die "dodoc failed"
	prepgamesdirs
}
