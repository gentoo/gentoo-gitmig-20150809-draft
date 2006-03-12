# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdljump/sdljump-0.91.1.ebuild,v 1.2 2006/03/12 15:49:29 wolf31o2 Exp $

inherit versionator eutils games

MY_PV=$(replace_version_separator 2 '-')

DESCRIPTION="XJump clone"
HOMEPAGE="http://sdljump.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="sys-libs/zlib
	>=media-libs/jpeg-6b-r5
	>=media-libs/libpng-1.2.8
	>=media-libs/libsdl-1.2.8-r1
	>=media-libs/sdl-image-1.2.3-r1
	>=media-libs/tiff-3.7.3
	virtual/opengl
	|| (
		(
			media-libs/mesa
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdmcp
			x11-libs/libXext )
		virtual/x11 )"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's/\\n//' sdljump.6 \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-configure.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO

	newicon skins/xjump/hero1.0.png ${PN}.png
	make_desktop_entry ${PN} "SDL Jump"

	prepgamesdirs
}
