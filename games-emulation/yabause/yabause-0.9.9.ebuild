# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/yabause/yabause-0.9.9.ebuild,v 1.1 2009/01/13 03:43:24 mr_bones_ Exp $

EAPI=1
inherit games

DESCRIPTION="A Sega Saturn emulator"
HOMEPAGE="http://yabause.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	x11-libs/gtkglext
	virtual/opengl
	virtual/glu
	virtual/glut
	media-libs/libsdl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	egamesconf \
		--datadir=/usr/share \
		--with-port=gtk \
		|| die
	emake -C src/c68k gen68k || die "emake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog GOALS README README.LIN TODO
	prepgamesdirs
}
