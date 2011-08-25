# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ssc/ssc-0.8.ebuild,v 1.11 2011/08/25 11:23:13 flameeyes Exp $

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
	dev-games/ode
	>=media-libs/freetype-2
	media-libs/libpng"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:/usr/local/share/:${GAMES_DATADIR}/:" \
		src/{asteroid.cc,audio.cc,config.cc,menu.cc} \
		|| die "sed failed"
	sed -i \
		-e '/CXXFLAGS=$OPT_CXXFLAGS/d' \
		configure \
		|| die "sed configure failed"
	epatch \
		"${FILESDIR}"/${P}-gcc34.patch \
		"${FILESDIR}"/${P}-ode.patch
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "You may need to copy ${GAMES_DATADIR}/ssc/ssc.conf to"
	elog "~/.ssc/ssc.conf and modify it to suit your needs before"
	elog "the game will work on your system.  You should be able"
	elog "to cut and paste the commands below:"
	echo
	elog "mkdir ~/.ssc/"
	elog "cp ${GAMES_DATADIR}/ssc/ssc.conf ~/.ssc/"
	echo
}
