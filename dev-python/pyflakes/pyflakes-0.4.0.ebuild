# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyflakes/pyflakes-0.4.0.ebuild,v 1.4 2010/03/07 12:40:57 ssuominen Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Passive checker for python programs."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodPyflakes http://pypi.python.org/pypi/pyflakes"
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ia64 x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="test"

DEPEND="test? ( dev-python/nose dev-python/twisted )"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}
