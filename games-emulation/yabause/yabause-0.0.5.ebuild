# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/yabause/yabause-0.0.5.ebuild,v 1.3 2004/06/24 22:37:47 agriffis Exp $

inherit games

DESCRIPTION="A Sega Saturn emulator"
HOMEPAGE="http://yabause.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""
DEPEND="media-libs/libsdl
	media-libs/sdl-image"

src_install() {
	egamesinstall || die "egamesinstall failed"
	dodoc AUTHORS ChangeLog TODO README
}
