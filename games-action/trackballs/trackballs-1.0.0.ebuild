# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/trackballs/trackballs-1.0.0.ebuild,v 1.2 2004/03/01 16:19:56 dholm Exp $

inherit eutils games

DESCRIPTION="simple game similar to the classical game Marble Madness"
HOMEPAGE="http://trackballs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${PN}-music-0.9.0.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	>=dev-util/guile-1.6*
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's/icons//' share/Makefile.in \
			|| die "sed share/Makefile.in failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-highscores=${GAMES_STATEDIR}/${PN}-highscores || \
			die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install            || die "make install failed"
	insinto /usr/share/pixmaps
	doins share/icons/*png || die "doins failed"
	make_desktop_entry trackballs "Trackballs" trackballs-48x48.png
	insinto "${GAMES_DATADIR}/${PN}/music"
	doins "${WORKDIR}"/tb_*.ogg            || die "doins failed"
	dodoc AUTHORS ChangeLog README* NEWS   || die "dodoc failed"
	prepgamesdirs
}
