# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/soya/soya-0.8.2.ebuild,v 1.1 2004/11/02 11:00:44 kloeri Exp $

inherit distutils

IUSE=""
MY_P=${P/soya/Soya}
DESCRIPTION="A high-level 3D engine for Python, designed with games in mind"
SRC_URI="http://download.gna.org/soya/${MY_P}.tar.bz2"
HOMEPAGE="http://home.gna.org/oomadness/en/soya/"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"

# Documented to need PIL (imaging) and pyrex
# pyrex isn't actually needed for normal building of non-cvs.
# Versions are based off soya 0.6 ebuild; they're mainly undocumented.
DEPEND="virtual/x11
	virtual/opengl
	>=dev-lang/python-2.2.2
	>=dev-python/editobj-0.3.1
	>=media-libs/libsdl-1.2.4
	>=media-libs/sdl-gfx-2.0.3
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-net-1.2.4
	>=media-libs/sdl-sound-0.1.5
	>=media-libs/cal3d-0.9
	>=media-libs/libpng-1.2.5
	>=media-libs/freetype-2.1.5
	dev-python/imaging"

S=${WORKDIR}/${MY_P}

src_compile() {
	distutils_src_compile
}
