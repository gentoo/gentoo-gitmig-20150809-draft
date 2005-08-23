# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/luola/luola-1.2.9.ebuild,v 1.1 2005/08/23 18:11:44 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A 2D multiplayer arcade game resembling V-Wing"
HOMEPAGE="http://luolamies.org/software/luola/"
SRC_URI="http://luolamies.org/software/luola/${P}.tar.gz
	http://www.luolamies.org/software/luola/stdlevels.tar.gz
	http://www.luolamies.org/software/luola/nostalgy.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-gfx
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/README.Nostalgy" "${S}" || die "mv failed"
	sed -i \
		-e '/PACKAGE_DATA_DIR/s:${\(ac_default_\)\?prefix}/::' \
		"${S}/configure" \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--enable-sound || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodir "${GAMES_DATADIR}/${PN}/levels"
	cp "${WORKDIR}/"*.{lev,png,jpg} "${D}${GAMES_DATADIR}/${PN}/levels"
	dodoc AUTHORS ChangeLog DATAFILE FAQ LEVELFILE README* TODO
	doicon luola.png
	make_desktop_entry luola Luola
	prepgamesdirs
}
