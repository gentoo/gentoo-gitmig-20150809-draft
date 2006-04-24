# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ssc/ssc-0.8.ebuild,v 1.9 2006/04/24 15:39:21 tupone Exp $

inherit eutils games

DESCRIPTION="2D Geometric Space Combat"
HOMEPAGE="http://sscx.sourceforge.net/"
SRC_URI="mirror://sourceforge/sscx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/freetype"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:/usr/local/share/:${GAMES_DATADIR}/:" \
		src/{asteroid.cc,audio.cc,config.cc,menu.cc} \
		|| die "sed failed"
	sed -i \
		-e "/CXXFLAGS/s:-Werror::" \
		configure
	epatch "${FILESDIR}/${P}-gcc34.patch"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "You may need to copy ${GAMES_DATADIR}/ssc/ssc.conf to"
	einfo "~/.ssc/ssc.conf and modify it to suit your needs before"
	einfo "the game will work on your system.  You should be able"
	einfo "to cut and paste the commands below:"
	echo
	einfo "mkdir ~/.ssc/"
	einfo "cp ${GAMES_DATADIR}/ssc/ssc.conf ~/.ssc/"
	echo
}
