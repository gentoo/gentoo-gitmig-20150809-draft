# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/trackballs/trackballs-0.9.2.ebuild,v 1.3 2004/04/19 20:54:37 wolf31o2 Exp $

inherit games eutils

DESCRIPTION="simple game similar to the classical game Marble Madness"
HOMEPAGE="http://trackballs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${PN}-music-0.9.0.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

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
	automake || die "automake failed"
}

src_compile() {
	egamesconf \
		--with-highscores=${GAMES_STATEDIR}/${PN}-highscores || \
			die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /usr/share/applications
	make DESTDIR="${D}" install            || die "make install failed"
	insinto "${GAMES_DATADIR}/${PN}/music"
	doins "${WORKDIR}"/tb_*.ogg            || die "doins failed"
	dodoc AUTHORS ChangeLog README* NEWS   || die "dodoc failed"
	prepgamesdirs
}
