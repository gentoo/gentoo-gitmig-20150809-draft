# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/3to2/3to2-1.0.ebuild,v 1.4 2013/01/18 23:42:02 mgorny Exp $

EAPI=5

PYTHON_COMPAT=(python2_7)
inherit distutils-r1

DESCRIPTION="Refactors valid 3.x syntax into valid 2.x syntax, if a syntactical conversion is possible"
HOMEPAGE="http://pypi.python.org/pypi/3to2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

python_test() {
	"${PYTHON}" "${BUILD_DIR}"/lib/lib3to2/tests/test_all_fixers.py \
		|| die "Tests fail with ${EPYTHON}"
}
