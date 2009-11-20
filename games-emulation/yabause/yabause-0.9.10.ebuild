# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/yabause/yabause-0.9.10.ebuild,v 1.2 2009/11/20 15:19:46 maekke Exp $

EAPI=2
inherit games

DESCRIPTION="A Sega Saturn emulator"
HOMEPAGE="http://yabause.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="openal sdl"

RDEPEND="x11-libs/gtk+:2
	x11-libs/gtkglext
	virtual/opengl
	virtual/glu
	virtual/glut
	openal? ( media-libs/openal )
	sdl? ( media-libs/libsdl[opengl?,video] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--datadir=/usr/share \
		--with-port=gtk \
		$(use_with sdl) \
		$(use_with openal)
}

src_compile() {
	emake -C src/c68k gen68k || die "emake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog GOALS README README.LIN
	prepgamesdirs
}
