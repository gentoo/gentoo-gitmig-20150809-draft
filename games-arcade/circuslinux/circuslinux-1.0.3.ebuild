# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/circuslinux/circuslinux-1.0.3.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

DESCRIPTION="clone of the Atari 2600 game \"Circus Atari\""
SRC_URI="ftp://ftp.sonic.net/pub/users/nbs/unix/x/circus-linux/${P}.tar.gz"
HOMEPAGE="http://www.newbreedsoftware.com/circus-linux/"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	dodoc *.txt
}
