# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numarray/numarray-1.5.2-r1.ebuild,v 1.11 2008/05/21 15:13:32 jer Exp $

NEED_PYTHON=2.3

inherit distutils

DOC_PV=1.5
DESCRIPTION="Large array processing extension module for Python"
SRC_URI="mirror://sourceforge/numpy/${P}.tar.gz
	doc? ( mirror://sourceforge/numpy/${PN}-${DOC_PV}.html.tar.gz )"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/numarray"

RDEPEND="lapack? ( virtual/cblas virtual/lapack )"

DEPEND="${RDEPEND}
	lapack? ( dev-util/pkgconfig )"

IUSE="doc lapack"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~x86 ~x86-fbsd"
LICENSE="BSD"

DOCS="LICENSE.txt Doc/*.txt Doc/release_notes/ANNOUNCE-${PV:0:3}"

# test with lapack buggy on amd64 (at least)
#RESTRICT="amd64? ( lapack? ( test ) )"

use lapack && unset LDFLAGS

# ex usage: pkgconf_cfg --libs-only-l cblas: ['cblas','atlas']
pkgconf_cfg() {
	local cfg="["
	for i in $(pkg-config "$@"); do
		cfg="${cfg}'${i:2}'"
	done
	echo "${cfg//\'\'/','}]"
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	# include Python.h from header files using the PyObject_HEAD macro.
	epatch "${FILESDIR}"/${P}-includes.patch

	# fix refcount problem from a debian bug
	epatch "${FILESDIR}"/${P}-refcount.patch

	# Fix missing exceptions (e.g. divide by zero, overflow) in FreeBSD
	# (i.e. need to include "__FreeBSD__" in pre-processor conditionals)
	epatch "${FILESDIR}"/${P}-freebsd.patch

	# fix only for python-2.5 (fix still uncomplete, see bug #191240)
	distutils_python_version
	[[ "${PYVER}" == 2.5 ]] && epatch "${FILESDIR}"/${P}-python25.patch

	# array_protocol tests are buggy with various numeric/numpy versions
	sed -i \
		-e '/array_protocol/d' \
		Lib/testall.py || die "sed testall failed"

	# configure cfg_packages.py for lapack
	if use lapack; then
		sed -i \
			-e '/^if USE_LAPACK:/iUSE_LAPACK = True' \
			-e "s:\['/usr/local/lib/atlas'\]:$(pkgconf_cfg --libs-only-L cblas lapack):g" \
			-e "s:\[\"/usr/local/include/atlas\"\]:$(pkgconf_cfg --cflags-only-I cblas lapack):g" \
			-e "s:\['lapack', 'cblas', 'f77blas', 'atlas', 'g2c', 'm'\]:$(pkgconf_cfg --libs-only-l cblas lapack):g" \
			cfg_packages.py || die "sed for lapack failed"
	fi

	"${python}" setup.py config --gencode || die "API code generation failed"
}

src_test() {
	cd build/lib*
	cp "${S}"/Lib/testdata.fits numarray
	PYTHONPATH=. "${python}" -c \
		"from numarray.testall import test;import sys;sys.exit(test())"  2>&1 \
		| tee test.log
	grep -q -i failed test.log  && die "failed tests in ${PWD}/test.log"
	rm -f numarray/testdata.fits test*.*
}

src_install() {
	distutils_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r Examples || die "install examples failed"
		dohtml "${WORKDIR}"/${PN}-${DOC_PV}/* || die "dohtml failed"
	fi
}
