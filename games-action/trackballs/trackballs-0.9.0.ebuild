# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/app-games

inherit games eutils

DESCRIPTION="simple game similar to the classical game Marble Madness"
HOMEPAGE="http://trackballs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${PN}-music-${PV}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/opengl
	media-libs/libsdl
	>=dev-util/guile-1.6*
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${PV}-sparkle.patch
	cd ${S}/share/icons
	epatch ${FILESDIR}/${PV}-destdir-icons.patch
	cd ${S}
	automake || die
}

src_compile() {
	egamesconf \
		--with-highscores=${GAMES_STATEDIR}/${PN}-highscores \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make install DESTDIR=${D} || die
	cp ${WORKDIR}/tb_*.ogg  ${D}/${GAMES_DATADIR}/${PN}/music/
	dodoc AUTHORS ChangeLog COPYING* README* NEWS
	prepgamesdirs
}
