# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/spout/spout-1.3.ebuild,v 1.2 2004/11/11 00:32:49 josejx Exp $

inherit eutils games

MY_P="spout-unix-${PV}"
DESCRIPTION="Abstract Japanese caveflier / shooter"
HOMEPAGE="http://code.mizzenblog.com/category/spout/"
SRC_URI="http://code.mizzenblog.com/spout/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/x11
	>=media-libs/libsdl-1.2.6"

S="${WORKDIR}/${MY_P}"

src_install() {
	dogamesbin spout || die "dogamesbin failed"
	insinto /usr/share/pixmaps
	doins spout.png
	make_desktop_entry spout "Spout" spout.png
	dodoc README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "To play in fullscreen mode, do 'spout f'."
	einfo "To play in a greater resolution, do 'spout x', where"
	einfo "x is an integer; the larger x is, the higher the resolution."
	echo
	einfo "To play:"
	einfo "Accelerate - spacebar, enter, z, x"
	einfo "Pause - escape"
	einfo "Exit - shift+escape"
	einfo "Rotate - left or right"
	echo
}
