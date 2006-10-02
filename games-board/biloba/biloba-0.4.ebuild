# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/biloba/biloba-0.4.ebuild,v 1.1 2006/10/02 06:42:21 mr_bones_ Exp $

inherit autotools eutils games

DESCRIPTION="a board game, up to 4 players, with AI and network."
HOMEPAGE="http://perso.wanadoo.fr/biloba/"
SRC_URI="mirror://sourceforge/biloba/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.6
	media-libs/sdl-image
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# "es" data were installed in /usr/games/share instead of /usr/share/games
	# X11 headers are checked but not used, everything is done through SDL
	epatch \
		"${FILESDIR}"/${P}-fix-es-data-install-path.patch \
		"${FILESDIR}"/${P}-no-X11-dep.patch \
		"${FILESDIR}"/${P}-not-windows.patch

	# "missing" file is old, and warns about --run not being supported
	rm -f missing
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	newicon biloba_icon.png biloba.png
	make_desktop_entry biloba Biloba
	prepgamesdirs
}
