# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/pymmlib/pymmlib-0.9.8.ebuild,v 1.9 2010/09/16 17:30:08 scarabeus Exp $

inherit multilib python

DESCRIPTION="Software toolkit and library of routines for the analysis and manipulation of macromolecular structural models"
HOMEPAGE="http://pymmlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/pymmlib/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
RDEPEND="media-libs/freeglut
	dev-python/pygtkglext
	>=dev-python/numpy-0.9.8
	virtual/opengl
	virtual/glu
	x11-libs/libXmu"
DEPEND="${RDEPEND}"

src_compile() {
	python setup.py build || die "build failed"
}

src_install() {
	python setup.py install --prefix="${D}/usr" || die "install failed"
	dobin "${S}"/applications/* "${S}"/examples/*
	dodoc "${S}"/README.txt
	dohtml -r "${S}"/doc

	# numpy >= 0.9.8 moved lost of numpy.linalg methods to numpy.linalg.old
	local b="numpy.linalg"
	ebegin "Updating for numpy >= 0.9.8"
	find "${D}" -name '*.py' \
	| xargs sed -i \
		-e "s:\(${b}.\)\(determinant\):\1old.\2:g" \
		-e "s:\(${b}.\)\(eigenvalues\):\1old.\2:g" \
		-e "s:\(${b}.\)\(eigenvectors\):\1old.\2:g" \
		-e "s:\(${b}.\)\(inverse\):\1old.\2:g" \
		-e "s:\(import numpy\):\1\nimport numpy.linalg.old:g"
	eend $?
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/mmLib
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/mmLib
}
