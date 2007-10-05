# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/extreme-tuxracer/extreme-tuxracer-0.35.ebuild,v 1.2 2007/10/05 01:33:48 nyhm Exp $

inherit eutils games

DESCRIPTION="High speed arctic racing game based on Tux Racer"
HOMEPAGE="http://www.extremetuxracer.com/"
SRC_URI="mirror://sourceforge/${PN/-}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/opengl
	dev-lang/tcl
	virtual/glu
	media-libs/sdl-mixer
	media-libs/freetype
	media-libs/libpng
	x11-libs/libXmu
	x11-libs/libXi"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog
	doicon "${FILESDIR}"/${PN}.svg
	make_desktop_entry etracer "Extreme Tux Racer" ${PN}.svg
	prepgamesdirs
}
