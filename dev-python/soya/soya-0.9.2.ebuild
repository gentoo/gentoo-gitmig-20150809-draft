# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/soya/soya-0.9.2.ebuild,v 1.4 2006/04/26 18:23:47 fserb Exp $

inherit distutils

MY_P=${P/soya/Soya}
DESCRIPTION="A high-level 3D engine for Python, designed with games in mind"
HOMEPAGE="http://oomadness.tuxfamily.org/en/soya/"
SRC_URI="http://download.gna.org/soya/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="ode"

# Documented to need PIL (imaging) and pyrex
# pyrex isn't actually needed for normal building of non-cvs.
# Versions are based off soya 0.6 ebuild; they're mainly undocumented.
DEPEND="virtual/opengl
	>=dev-lang/python-2.2.2
	>=media-libs/libsdl-1.2.4
	>=media-libs/sdl-gfx-2.0.3
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-net-1.2.4
	>=media-libs/sdl-sound-0.1.5
	>=media-libs/cal3d-0.9
	>=media-libs/libpng-1.2.5
	>=media-libs/freetype-2.1.5
	ode? ( >=dev-games/ode-0.5 )
	dev-python/imaging"

RDEPEND="${DEPEND}
	>=dev-python/editobj-0.3.1"

S=${WORKDIR}/${MY_P}

src_compile() {
	if ! use ode; then
		sed -i -e "s/^\(USE_ODE = \).*$/\1False/" setup.py || die "sed install.py failed"
	fi
	distutils_src_compile
}
