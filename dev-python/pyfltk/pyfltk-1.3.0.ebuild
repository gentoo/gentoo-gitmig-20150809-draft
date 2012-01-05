# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfltk/pyfltk-1.3.0.ebuild,v 1.2 2012/01/05 17:19:56 ssuominen Exp $

# FIXME: MakeSwig.py execution should be made work from pyfltk-1.1.5.ebuild

EAPI=4

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

MY_P=pyFltk-${PV}

DESCRIPTION="Python interface to Fltk library"
HOMEPAGE="http://pyfltk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=x11-libs/fltk-1.3.0:1[opengl]"
DEPEND="${RDEPEND}
	>=dev-lang/swig-2.0.4"

PYTHON_CXXFLAGS=("2.* + -fno-strict-aliasing")
PYTHON_MODNAME="fltk"
DOCS="CHANGES README TODO"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-linux-3.x-detection.patch
}

src_install() {
	distutils_src_install

	# FIXME: Install documentation ourself. Would some argument to distutils_src_install
	# instead help?
	rm -rf "${ED}"/usr/lib*/python*/site-packages/fltk/docs
	dohtml fltk/docs/*
}
