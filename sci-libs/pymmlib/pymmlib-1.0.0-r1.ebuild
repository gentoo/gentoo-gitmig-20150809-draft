# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/pymmlib/pymmlib-1.0.0-r1.ebuild,v 1.8 2011/06/26 10:22:51 jlec Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils multilib

DESCRIPTION="Toolkit and library for the analysis and manipulation of macromolecular structural models"
HOMEPAGE="http://pymmlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/pymmlib/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="
	dev-python/numpy
	dev-python/pygtkglext
	media-libs/freeglut
	virtual/glu
	virtual/opengl
	x11-libs/libXmu"
DEPEND="${RDEPEND}"

src_prepare() {
	python_convert_shebangs $(python_get_version -f) "${S}"/applications/* "${S}"/examples/*
	distutils_src_prepare
}

src_install() {
	distutils_src_install
	dobin "${S}"/applications/* "${S}"/examples/* || die
	dodoc "${S}"/README.txt || die
	dohtml -r "${S}"/doc || die
}
