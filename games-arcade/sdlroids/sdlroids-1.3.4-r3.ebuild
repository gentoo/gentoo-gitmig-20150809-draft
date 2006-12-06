# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdlroids/sdlroids-1.3.4-r3.ebuild,v 1.9 2006/12/06 17:09:46 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Asteroids Clone for X using SDL"
HOMEPAGE="http://david.hedbor.org/projects/sdlroids/"
SRC_URI="mirror://sourceforge/sdlroids/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.1.8
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i \
		-e 's/$(SOUNDSDIR)/$(DESTDIR)$(SOUNDSDIR)/' \
		-e 's/$(GFXDIR)/$(DESTDIR)$(GFXDIR)/' Makefile.in \
		|| die "sed Makefile.in failed"
	epatch "${FILESDIR}/${PV}-sound.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README.* TODO
	prepgamesdirs
}
