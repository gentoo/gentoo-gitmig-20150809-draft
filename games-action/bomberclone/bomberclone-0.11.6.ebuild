# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bomberclone/bomberclone-0.11.6.ebuild,v 1.1 2005/03/31 18:12:23 mr_bones_ Exp $

inherit games

DESCRIPTION="BomberMan clone with network game support"
HOMEPAGE="http://www.bomberclone.de/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ppc x86"
IUSE="X"

DEPEND="virtual/libc
	X? ( virtual/x11 )
	>=media-libs/libsdl-1.1.0
	media-libs/sdl-image
	media-libs/sdl-mixer"

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

	dodir "${GAMES_DATADIR}/${PN}"
	cp -R data/{gfx,maps,player,tileset}/ "${D}/${GAMES_DATADIR}/${PN}" \
		|| die "cp failed"

	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
