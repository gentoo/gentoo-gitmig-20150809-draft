# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/circuslinux/circuslinux-1.0.3.ebuild,v 1.9 2004/11/11 20:44:03 wolf31o2 Exp $

inherit gnuconfig

DESCRIPTION="clone of the Atari 2600 game \"Circus Atari\""
SRC_URI="ftp://ftp.sonic.net/pub/users/nbs/unix/x/circus-linux/${P}.tar.gz"
HOMEPAGE="http://www.newbreedsoftware.com/circus-linux/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~alpha sparc ~amd64"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

src_compile() {
	gnuconfig_update
	econf || die
	emake || die
}

src_install () {
	einstall || die
	dodoc *.txt
}
