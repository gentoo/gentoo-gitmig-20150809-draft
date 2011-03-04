# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyzmq/pyzmq-2.0.10.1.ebuild,v 1.1 2011/03/04 17:27:48 djc Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

DESCRIPTION="PyZMQ is a lightweight and super-fast messaging library built on top of the ZeroMQ library"
HOMEPAGE="http://www.zeromq.org/bindings:python http://pypi.python.org/pypi/pyzmq"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="net-libs/zeromq
		dev-python/setuptools
		doc? ( >=dev-python/sphinx-0.6 )"
RDEPEND=""

DOCS="README.rst"

src_compile() {
	distutils_src_compile
	if use doc; then
		einfo "Generation of documentation"
		cd docs
		PYTHONPATH=".." emake html || die "Building of documentation failed"
	fi
}

src_test() {
	testing() {
		"$(PYTHON)" setup.py build_ext --inplace
		"$(PYTHON)" setup.py test
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r docs/_build/html/* || die "Installation of documentation failed"
	fi
}
