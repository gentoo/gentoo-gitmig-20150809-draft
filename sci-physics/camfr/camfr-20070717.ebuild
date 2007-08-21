# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/camfr/camfr-20070717.ebuild,v 1.1 2007/08/21 20:39:12 pbienst Exp $

inherit eutils distutils fortran python

DESCRIPTION="Full vectorial Maxwell solver based on eigenmode expansion"
HOMEPAGE="http://camfr.sourceforge.net/"
SRC_URI="mirror://sourceforge/camfr/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/python
	dev-python/numpy
	sci-libs/scipy
	>=dev-python/matplotlib-0.90.1
	>=dev-libs/boost-1.30.2
	>=dev-python/imaging-1.1.4
	dev-libs/blitz
	virtual/lapack"

DEPEND="${RDEPEND}
	dev-util/scons"

FORTAN="gfortran g77"

S=${WORKDIR}/${P/-/_}

pkg_setup() {
	if ! built_with_use dev-lang/python tk \
		|| ! built_with_use dev-python/imaging tk ; then
		eerror "Python and/or imaging don't have Tk support enabled."
		eerror "Set the tk USE flag and reinstall python and imaging before continuing."
		die
	fi
	fortran_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp machine_cfg.py{.gentoo,} || die
}

src_test() {
	PYTHONPATH=.:visualisation ${python} testsuite/camfr_test.py \
		|| die "tests failed"
}

src_install() {
	distutils_src_install
	dodoc docs/camfr.pdf || die
}
