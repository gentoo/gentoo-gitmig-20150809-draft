# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/soya/soya-0.13_rc1.ebuild,v 1.2 2010/09/16 16:44:21 scarabeus Exp $

inherit distutils

MY_PV=${PV/_}
MY_P=Soya-${MY_PV}
TUT_P=SoyaTutorial-${MY_PV}

DESCRIPTION="A high-level 3D engine for Python, designed with games in mind"
HOMEPAGE="http://oomadness.nekeme.net/Soya/FrontPage"
SRC_URI="http://download.gna.org/soya/${MY_P}.tar.bz2
	doc? ( http://download.gna.org/soya/${TUT_P}.tar.bz2 )
	examples? ( http://download.gna.org/soya/${TUT_P}.tar.bz2 )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc examples openal"

DEPEND="virtual/opengl
	media-libs/freeglut
	>=dev-lang/python-2.4.2
	>=dev-python/imaging-1.1.5
	>=media-libs/cal3d-0.10
	>=media-libs/glew-1.3.3
	>=media-libs/freetype-2.1.5
	media-fonts/freefonts
	>=media-libs/libsdl-1.2.8
	>=dev-games/ode-0.5
	openal? ( media-libs/openal
		>=dev-python/pyopenal-0.1.6 )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	use openal || sed -i -e 's/^USE_OPENAL.*/USE_OPENAL = 0/' setup.py
	distutils_src_compile
}

src_install() {
	distutils_src_install

	insinto /usr/share/${PF}
	if use doc ; then
		cd "${WORKDIR}/${TUT_P}/doc"
		doins soya_guide.pdf pudding/pudding.pdf
	fi
	if use examples ; then
		cd "${WORKDIR}/${TUT_P}"
		doins -r tutorial
	fi
}
