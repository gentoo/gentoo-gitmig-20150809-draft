# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/pymmlib/pymmlib-0.9.7.ebuild,v 1.2 2006/01/07 08:15:40 spyderous Exp $

inherit python

DESCRIPTION="Software toolkit and library of routines for the analysis and manipulation of macromolecular structural models"
HOMEPAGE="http://pymmlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/pymmlib/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="virtual/glut
	dev-python/pygtkglext
	dev-python/numeric
	virtual/opengl
	virtual/glu
	|| ( x11-libs/libXmu virtual/x11 )"
DEPEND="${RDEPEND}"

src_compile() {
	python setup.py build || die "build failed"
}

src_install() {
	python setup.py install --prefix="${D}/usr" || die "install failed"
	EXEDESTTREE="/usr/bin" doexe ${S}/applications/* ${S}/examples/*
	dodoc ${S}/README.txt
	dohtml -r ${S}/doc
}

pkg_postinst() {
	python_mod_optimize ${ROOT}lib/python2.4/site-packages/mmLib
}
