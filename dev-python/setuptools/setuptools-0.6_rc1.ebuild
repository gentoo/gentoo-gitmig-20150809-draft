# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/setuptools/setuptools-0.6_rc1.ebuild,v 1.2 2006/09/10 16:51:16 the_paya Exp $

inherit distutils

MY_P=${P/_rc/c}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A collection of enhancements to the Python distutils including easy install"
HOMEPAGE="http://peak.telecommunity.com/DevCenter/setuptools"
SRC_URI="http://cheeseshop.python.org/packages/source/s/setuptools/${MY_P}.zip"

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-lang/python-2.4.2"
DEPEND="${RDEPEND}
	app-arch/unzip"

DOCS="EasyInstall.txt api_tests.txt pkg_resources.txt setuptools.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# The files in the tarball have 666 permissions and get installed
	# that way if we do not chmod them.
	find -type d -print0 | xargs -0 chmod 755
	find -type f -print0 | xargs -0 chmod 644
}

src_test() {
	"${python}" setup.py test || die "tests failed"
}
