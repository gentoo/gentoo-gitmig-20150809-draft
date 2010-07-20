# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testtools/testtools-0.9.4.ebuild,v 1.3 2010/07/20 07:31:17 fauli Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils versionator eutils

SERIES="$(get_version_component_range 1-2)"

DESCRIPTION="Extensions to the Python unittest library"
HOMEPAGE="https://launchpad.net/testtools"
SRC_URI="http://launchpad.net/${PN}/${SERIES}/${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	# fixed upstream for everything > 0.9.4
	epatch "${FILESDIR}"/${P}-fix_test.patch
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" -m testtools.run testtools.tests.test_suite
	}
	python_execute_function testing
}
