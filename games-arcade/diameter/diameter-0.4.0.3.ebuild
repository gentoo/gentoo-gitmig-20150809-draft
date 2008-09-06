# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/diameter/diameter-0.4.0.3.ebuild,v 1.1 2008/09/06 00:11:47 nyhm Exp $

inherit eutils autotools games

DESCRIPTION="Arcade game with elements of economy and adventure"
HOMEPAGE="http://gamediameter.sourceforge.net/"
SRC_URI="mirror://sourceforge/gamediameter/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-games/guichan-0.8
	media-libs/libpng
	virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/gamediameter

pkg_setup() {
	if ! built_with_use dev-games/guichan opengl sdl; then
		die "dev-games/guichan built without USE=\"opengl sdl\""
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:gamediameter:diameter:" \
		configure.in \
		|| die "sed failed"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/texture/gui/eng/main/logo.png ${PN}.png
	make_desktop_entry ${PN} Diameter
	dodoc README
	prepgamesdirs
}
