# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/yabause/yabause-0.6.0.ebuild,v 1.1 2005/12/27 18:43:12 mr_bones_ Exp $

inherit games

DESCRIPTION="A Sega Saturn emulator"
HOMEPAGE="http://yabause.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="gtk"

RDEPEND="gtk? ( =x11-libs/gtk+-2* )
	virtual/opengl
	media-libs/libsdl
	media-libs/sdl-gfx
	media-libs/sdl-image"
DEPEND="${RDEPEND}
	gtk? ( dev-util/pkgconfig )"

S=${WORKDIR}/${PN}

src_compile() {
	egamesconf $(use_with gtk) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog TODO README
	prepgamesdirs
}
