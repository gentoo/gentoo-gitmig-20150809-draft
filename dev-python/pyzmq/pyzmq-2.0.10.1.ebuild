# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyzmq/pyzmq-2.0.10.1.ebuild,v 1.6 2011/03/07 22:21:10 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="*:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

DESCRIPTION="PyZMQ is a lightweight and super-fast messaging library built on top of the ZeroMQ library"
HOMEPAGE="http://www.zeromq.org/bindings:python http://pypi.python.org/pypi/pyzmq"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
# IUSE="doc"

RDEPEND="net-libs/zeromq"
# dev-python/cython required only as long as pyzmq-2.0.10.1-python-3.2.patch is applied.
DEPEND="${RDEPEND}
	dev-python/cython"
#	doc? (
#		dev-python/setuptools
#		>=dev-python/sphinx-0.6
#	)

DOCS="README.rst"
PYTHON_MODNAME="zmq"

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/${P}-python-2.7.patch"
	epatch "${FILESDIR}/${P}-python-3.1.patch"
	epatch "${FILESDIR}/${P}-python-3.2.patch"
}

src_compile() {
	distutils_src_compile

	if false && use doc; then
		einfo "Generation of documentation"
		if has_version ">=dev-python/sphinx-1.1"; then
			# Sphinx 1.1 probably will support Python 3.
			die "Untested environment. Ask Arfrever to update this code."
			PYTHONPATH="$(ls -d build-$(PYTHON -f --ABI)/lib.*)" "$(PYTHON -f)" setupegg.py build_sphinx || die "Generation of documentation failed"
		else
			local sphinx_python_abi="$(PYTHON -2 --ABI)"
			if [[ ! -d "build-${sphinx_python_abi}" ]]; then
				"$(PYTHON -2)" setup.py build -b "build-${sphinx_python_abi}" || die "Building for Sphinx failed"
			fi
			pushd docs > /dev/null
			PYTHONPATH="$(ls -d ../build-${sphinx_python_abi}/lib.*)" emake html || die "Generation of documentation failed"
			popd > /dev/null
		fi
	fi
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" nosetests -sv $(ls -d build-${PYTHON_ABI}/lib.*)
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

#	if use doc; then
#		dohtml -r docs/_build/html/* || die "Installation of documentation failed"
#	fi
}
