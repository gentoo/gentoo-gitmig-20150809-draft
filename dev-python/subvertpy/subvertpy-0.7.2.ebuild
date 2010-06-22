# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/subvertpy/subvertpy-0.7.2.ebuild,v 1.5 2010/06/22 18:38:12 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Alternative Python bindings for Subversion."
HOMEPAGE="http://samba.org/~jelmer/subvertpy/ http://pypi.python.org/pypi/subvertpy"
SRC_URI="http://samba.org/~jelmer/${PN}/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 LGPL-3 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND=">=dev-vcs/subversion-1.4
	!<dev-util/bzr-svn-0.5.0_rc2"
DEPEND="${RDEPEND}
	test? ( dev-python/nose )"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="NEWS AUTHORS"

src_test() {
	testing() {
		local module
		for module in _ra client repos wc; do
			ln -fs "../$(ls -d build-${PYTHON_ABI}/lib.*)/subvertpy/${module}.so" "subvertpy/${module}.so" || die "Symlinking subvertpy/${module}.so failed with Python ${PYTHON_ABI}"
		done

		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" nosetests
	}
	python_execute_function testing
}
