# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simpy/simpy-2.3.ebuild,v 1.5 2012/02/21 03:48:01 patrick Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="tk"
SUPPORT_PYTHON_ABIS="1"
# https://sourceforge.net/tracker/?func=detail&aid=3470332&group_id=62366&atid=500345
RESTRICT_PYTHON_ABIS="2.5 3.* 2.7-pypy-*"
PYTHON_MODNAME="SimPy"

inherit distutils

MY_P="${P/simpy/SimPy}"

DESCRIPTION="Simulation in Python is an object-oriented, process-based discrete-event simulation language"
HOMEPAGE="http://simpy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="LGPL-2.1"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-python/pytest )"

S="${WORKDIR}/${MY_P}"

src_test() {
	testing() {
		PYTHONPATH="." $(PYTHON) -c "import SimPy; SimPy.test()" || die
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

## fails with current sphinx
#	cd docs
#	emake man && doman build/man/*
#
#	if use doc; then
#		emake dirhtml singlehtml && dohtml -r build/html/* build/singlehtml/*
#		emake text changes && dodoc -r build/{text,changes}/*
#		emake latexpdf && dodoc -r build/latex*/*
#	fi
}
