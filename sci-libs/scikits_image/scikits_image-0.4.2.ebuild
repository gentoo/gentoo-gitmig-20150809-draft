# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scikits_image/scikits_image-0.4.2.ebuild,v 1.1 2011/12/20 06:34:06 bicatali Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MYPN="${PN/scikits_/scikits-}"

DESCRIPTION="Image processing routines for SciPy"
HOMEPAGE="http://scikits-image.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${MYPN}/${MYPN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gtk qt4"

RDEPEND="sci-libs/scipy
	sci-libs/scikits
	gtk? ( dev-python/pygtk )
	qt4? ( dev-python/PyQt4 )"
DEPEND="dev-python/numpy
	dev-python/cython
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

S="${WORKDIR}/${MYPN}-${PV}"
PYTHON_MODNAME="skimage"

src_compile() {
	distutils_src_compile
	if use doc; then
		"$(PYTHON -f)" setup.py build_sphinx || die "Generation of documentation failed"
	fi
}

src_test() {
	testing() {
		PYTHONPATH="$(dir -d build-${PYTHON_ABI}/lib*)" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	remove_scikits() {
		rm -f "${ED}"$(python_get_sitedir)/scikits/__init__.py || die
	}
	python_execute_function -q remove_scikits
	dodoc *.txt || die
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r build/sphinx/html || die
	fi
}
