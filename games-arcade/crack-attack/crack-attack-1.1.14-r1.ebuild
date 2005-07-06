# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/crack-attack/crack-attack-1.1.14-r1.ebuild,v 1.2 2005/07/06 22:56:39 vapier Exp $

inherit eutils flag-o-matic games

DESCRIPTION="Addictive OpenGL-based block game"
HOMEPAGE="http://www.nongnu.org/crack-attack/"
SRC_URI="http://savannah.nongnu.org/download/crack-attack/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc sparc x86"
IUSE="gtk sdl"

DEPEND="virtual/glut
	sdl? ( media-libs/libsdl media-libs/sdl-mixer )
	gtk? ( >=x11-libs/gtk+-2.6 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-glut.patch
}

src_compile() {
	egamesconf \
		--disable-binreloc \
		$(use_enable sdl sound) \
		$(use_enable gtk) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	dohtml -A xpm doc/*
	doicon data/crack-attack.xpm
	make_desktop_entry crack-attack Crack-attack crack-attack.xpm
	prepgamesdirs
}
