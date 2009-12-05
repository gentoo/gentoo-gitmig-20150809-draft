# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxattr/pyxattr-0.4.0.ebuild,v 1.8 2009/12/05 17:35:59 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python interface to xattr"
HOMEPAGE="http://sourceforge.net/projects/pyxattr/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm ia64 ppc ppc64 sh sparc x86"
IUSE="test"

RDEPEND="sys-apps/attr"
DEPEND="${RDEPEND}
		>=dev-python/setuptools-0.6_rc7-r1
		test? ( dev-python/nose )"
RESTRICT_PYTHON_ABIS="3.*"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}
