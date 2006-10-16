# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-sdl-games/ggz-sdl-games-0.0.13.ebuild,v 1.7 2006/10/16 18:56:23 nyhm Exp $

inherit games

DESCRIPTION="These are the SDL versions of the games made by GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ftp.belnet.be/packages/ggzgamingzone/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~ppc x86"
IUSE=""
RESTRICT="userpriv"

DEPEND="~dev-games/libggz-${PV}
	~dev-games/ggz-client-libs-${PV}
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	virtual/opengl
	x11-libs/libXcursor"

src_install() {
	if [[ -f "${ROOT}/${GAMES_SYSCONFDIR}"/ggz/ggz.modules ]] ; then
		dodir "${GAMES_SYSCONFDIR}"/ggz
		cp {"${ROOT}","${D}"}/"${GAMES_SYSCONFDIR}"/ggz/ggz.modules
	fi
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS QuickStart.GGZ README*
	prepgamesdirs
}
