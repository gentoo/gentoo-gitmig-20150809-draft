# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numpy/numpy-0.9.8.ebuild,v 1.2 2006/07/17 16:24:50 liquidx Exp $

inherit distutils

DESCRIPTION="Multi-dimensional array object and processing for Python."
SRC_URI="mirror://sourceforge/numpy/${P}.tar.gz"
HOMEPAGE="http://numeric.scipy.org/"
# numpy provides the latest version of dev-python/f2py
DEPEND=">=dev-lang/python-2.3
	!dev-python/f2py
	lapack? ( virtual/blas
		virtual/lapack )"
IUSE="lapack"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
LICENSE="BSD"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# sed to patch ATLAS libraries names (gentoo specific)
	sed -i \
		-e "s:f77blas:blas:g" \
		numpy/distutils/system_info.py

	if use lapack; then
		echo "[atlas]"  > site.cfg
		echo "include_dirs = /usr/include/atlas" >> site.cfg
		echo "atlas_libs = lapack, blas, cblas, atlas" >> site.cfg
		echo -n "library_dirs = /usr/$(get_libdir)/lapack:" >> site.cfg
		if [ -d "/usr/$(get_libdir)/blas/threaded-atlas" ]; then
			echo "/usr/$(get_libdir)/blas/threaded-atlas" >> site.cfg
		else
			echo "/usr/$(get_libdir)/blas/atlas" >> site.cfg
		fi
	else
		export ATLAS=None
	fi
}

# The test only works after install
# To be worked out.
#src_test() {
#	python -c "import numpy; numpy.test()" || \
#		die "test failed!"
#}

src_install() {
	distutils_src_install
	dodoc numpy/doc/*
}


