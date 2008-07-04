# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/camfr/camfr-20070717.ebuild,v 1.3 2008/07/04 17:34:47 bicatali Exp $

inherit eutils distutils fortran

DESCRIPTION="Full vectorial Maxwell solver based on eigenmode expansion"
HOMEPAGE="http://camfr.sourceforge.net/"
SRC_URI="mirror://sourceforge/camfr/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sci-libs/scipy
	dev-python/matplotlib
	dev-libs/boost
	dev-libs/blitz
	dev-python/imaging
	virtual/lapack"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/scons"

S="${WORKDIR}/${P/-/_}"

pkg_setup() {
	if  ! built_with_use dev-lang/python tk || \
		! built_with_use dev-python/imaging tk ; then
		eerror "Python and/or imaging don't have Tk support enabled."
		eerror "Set the tk USE flag and reinstall python and imaging before continuing."
		die
	fi
	FORTRAN="gfortran g77 ifc"
	fortran_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	cp machine_cfg.py{.gentoo,} || die
	sed -i -e '/^library_dirs/d'  -e '/^libs/d' machine_cfg.py || die
	local lapack_libs=
	for x in $(pkg-config --libs-only-l lapack); do
		lapack_libs="${lapack_libs}, \"${x#-l}\""
	done
	local lapack_libdirs=
	for x in $(pkg-config --libs-only-L lapack); do
		lapack_libdirs="${lapack_libdirs}, \"${x#-L}\""
	done
	cat <<-EOF >> machine_cfg.py
		library_dirs = [${lapack_libdirs}]
		libs = ["boost_python", "blitz"${lapack_libs}]
	EOF
}

src_test() {
	# trick to avoid X in testing (bug #229753)
	echo "backend : Agg" > matplotlibrc
	PYTHONPATH=".:visualisation" ${python} testsuite/camfr_test.py \
		|| die "tests failed"
	rm -f matplotlibrc
}

src_install() {
	distutils_src_install
	dodoc docs/camfr.pdf || die "doc install failed"
}
