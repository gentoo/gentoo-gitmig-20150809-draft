# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/extreme-tuxracer/extreme-tuxracer-0.4.ebuild,v 1.4 2009/01/04 08:01:28 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="High speed arctic racing game based on Tux Racer"
HOMEPAGE="http://www.extremetuxracer.com/"
SRC_URI="mirror://sourceforge/${PN/-}/${P/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/opengl
	dev-lang/tcl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer[mikmod]
	>=media-libs/freetype-2
	media-libs/libpng
	x11-libs/libXmu
	x11-libs/libXi"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${P/-}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog
	doicon "${FILESDIR}"/${PN}.svg
	make_desktop_entry etracer "Extreme Tux Racer" ${PN}
	prepgamesdirs
}
