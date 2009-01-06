# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/criticalmass/criticalmass-1.0.0.ebuild,v 1.4 2009/01/06 01:38:39 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="SDL/OpenGL space shoot'em up game"
HOMEPAGE="http://criticalmass.sourceforge.net/"
SRC_URI="mirror://sourceforge/criticalmass/CriticalMass-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ~ppc"
IUSE=""

DEPEND="media-libs/sdl-mixer
	media-libs/sdl-image[png]
	media-libs/libpng
	virtual/opengl"

S=${WORKDIR}/CriticalMass-${PV}
PATCHES=( "${FILESDIR}"/${P}-gcc43.patch )

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}${GAMES_BINDIR}/Packer"
	dohtml Readme.html
	dodoc TODO
	newicon critter.png ${PN}.png
	make_desktop_entry critter "Critical Mass"
	prepgamesdirs
}
