# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bomberclone/bomberclone-0.11.7.ebuild,v 1.2 2006/12/01 20:04:00 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="BomberMan clone with network game support"
HOMEPAGE="http://www.bomberclone.de/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 x86"
IUSE="X"

DEPEND=">=media-libs/libsdl-1.1.0
	media-libs/sdl-image
	media-libs/sdl-mixer
	X? ( x11-libs/libXt )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	find . -type d -name CVS -exec rm -rf \{\} \; 2> /dev/null
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_with X x) \
		--datadir="${GAMES_DATADIR_BASE}" || die
	sed -i \
		-e "/PACKAGE_DATA_DIR/ s:/usr/games/share/games/:${GAMES_DATADIR}/:" \
		config.h \
		|| die "sed config.h failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/{gfx,maps,player,tileset} || die "doins failed"

	dodoc AUTHORS ChangeLog README TODO
	doicon data/pixmaps/bomberclone.png
	make_desktop_entry bomberclone Bomberclone
	prepgamesdirs
}
