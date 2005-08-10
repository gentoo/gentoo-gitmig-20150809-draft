# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/luola/luola-1.2.7.ebuild,v 1.2 2005/08/10 19:32:19 r3pek Exp $

inherit eutils games

DESCRIPTION="A 2D multiplayer arcade game resembling V-Wing"
HOMEPAGE="http://www.saunalahti.fi/~laakkon1/linux/luola/index.php"
SRC_URI="http://www.saunalahti.fi/~laakkon1/linux/luola/bin/${P}.tar.gz
	 http://www.saunalahti.fi/~laakkon1/linux/luola/bin/stdlevels.tar.gz
	 http://www.saunalahti.fi/~laakkon1/linux/luola/bin/nostalgy.tar.gz
	 http://www.saunalahti.fi/~laakkon1/linux/luola/bin/demolevel.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-gfx
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/README.Nostalgy" "${S}" || die "mv failed"
	sed -i -e '/PACKAGE_DATA_DIR/s:${\(ac_default_\)\?prefix}/::' \
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
