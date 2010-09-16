# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/soya/soya-0.10.2.ebuild,v 1.6 2010/09/16 16:44:21 scarabeus Exp $

inherit distutils

MY_P=${P/soya/Soya}
MY_PN=${PN/soya/Soya}
DESCRIPTION="A high-level 3D engine for Python, designed with games in mind"
HOMEPAGE="http://oomadness.nekeme.net/Soya/FrontPage"
SRC_URI="http://download.gna.org/soya/${MY_P}.tar.bz2
	doc? ( http://download.gna.org/soya/${MY_PN}Tutorial-${PV}.tar.bz2 )
	examples? ( http://download.gna.org/soya/${MY_PN}Tutorial-${PV}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="doc examples ode openal"

# Documented to need PIL (imaging) and pyrex
# pyrex isn't actually needed for normal building of non-cvs.
DEPEND="virtual/opengl
	media-libs/freeglut
	>=dev-lang/python-2.4.2
	>=dev-python/imaging-1.1.5
	>=media-fonts/freefonts-0.10
	>=media-libs/cal3d-0.10
	>=media-libs/glew-1.3.3
	>=media-libs/freetype-2.1.5
	>=media-libs/libsdl-1.2.8
	>=media-libs/libpng-1.2.8
	ode? ( >=dev-games/ode-0.5 )"

RDEPEND="${DEPEND}
	>=dev-python/editobj-0.5.6
	openal? ( >=dev-python/pyopenal-0.1.4 )"

S="${WORKDIR}/${MY_P}"

src_compile() {

	rm "${S}"/pudding/test.py	# This file shouldn't be installed

	if ! use ode; then
		sed -i -e "s/^\(USE_ODE = \).*$/\1False/" setup.py || die "sed install.py failed"
	fi
	distutils_src_compile
}

src_install() {
	distutils_src_install
	if use doc; then
		cd "${WORKDIR}/${MY_PN}Tutorial-${PV}"
		insinto /usr/share/${PN}/doc
		doins doc/*
		insinto /usr/share/${PN}/doc/blendertut
		doins doc/blendertut/*
		insinto /usr/share/${PN}/doc/pudding
		doins doc/pudding/*
	fi
	if use examples; then
		cd "${WORKDIR}/${MY_PN}Tutorial-${PV}"
		insinto /usr/share/${PN}/tutorial
		doins tutorial/*
		insinto /usr/share/${PN}/tutorial/results
		doins tutorial/results/*
		insinto /usr/share/${PN}/tutorial/data/blender
		doins tutorial/data/blender/*
		insinto /usr/share/${PN}/tutorial/data/images
		doins tutorial/data/images/*
		insinto /usr/share/${PN}/tutorial/data/levels
		doins tutorial/data/levels/*
		insinto /usr/share/${PN}/tutorial/data/ms3d
		doins tutorial/data/ms3d/*
		insinto /usr/share/${PN}/tutorial/data/shapes
		doins tutorial/data/shapes/*
		insinto /usr/share/${PN}/tutorial/data/shapes/balazar
		doins tutorial/data/shapes/balazar/*
		insinto /usr/share/${PN}/tutorial/data/sounds
		doins tutorial/data/sounds/*
		insinto /usr/share/${PN}/tutorial/data/svg
		doins tutorial/data/svg/*
		insinto /usr/share/${PN}/tutorial/data/worlds
		doins tutorial/data/worlds/*
		insinto /usr/share/${PN}/tutorial/data/materials
		doins tutorial/data/materials/*
	fi
}
