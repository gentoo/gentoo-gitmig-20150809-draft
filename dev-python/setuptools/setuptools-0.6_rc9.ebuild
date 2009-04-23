# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/setuptools/setuptools-0.6_rc9.ebuild,v 1.2 2009/04/23 17:29:25 klausman Exp $

NEED_PYTHON="2.4"

inherit distutils eutils

MY_P="${P/_rc/c}"

DESCRIPTION="A collection of enhancements to the Python distutils including easy install"
HOMEPAGE="http://peak.telecommunity.com/DevCenter/setuptools"
SRC_URI="http://cheeseshop.python.org/packages/source/s/setuptools/${MY_P}.tar.gz"
LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc
~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${MY_P}"

DOCS="EasyInstall.txt api_tests.txt pkg_resources.txt setuptools.txt README.txt"

src_unpack() {
	distutils_src_unpack

	epatch "${FILESDIR}/${PN}-0.6_rc7-noexe.patch"

	# Remove tests that access the network (bugs #198312, #191117)
	rm setuptools/tests/test_packageindex.py
}

src_test() {
	PYTHONPATH="." "${python}" setup.py test || die "tests failed"
}
