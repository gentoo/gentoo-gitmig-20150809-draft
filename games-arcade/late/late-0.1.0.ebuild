# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/late/late-0.1.0.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

inherit games

DESCRIPTION="A game, similar to Barrack by Ambrosia Software"
SRC_URI="mirror://sourceforge/late/${P}.tar.bz2"
HOMEPAGE="http://late.sourceforge.net/"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=media-libs/libsdl-1.1.8
	media-libs/sdl-image"

src_install () {
	egamesinstall || die
	dodoc AUTHORS
}
