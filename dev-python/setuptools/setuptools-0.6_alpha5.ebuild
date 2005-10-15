# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/setuptools/setuptools-0.6_alpha5.ebuild,v 1.1 2005/10/15 05:41:59 pythonhead Exp $

inherit distutils

MY_P=${P/_alpha/a}
DESCRIPTION="A collection of enhancements to the Python distutils including easy install"
HOMEPAGE="http://peak.telecommunity.com/"
SRC_URI="http://cheeseshop.python.org/packages/source/s/setuptools/${MY_P}.zip"
LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-lang/python-2.4.2
	app-arch/zip"

src_install() {
	DOCS="EasyInstall.txt api_tests.txt pkg_resources.txt setuptools.txt"
	distutils_src_install
	distutils_python_version

	# create .pth file in site-packages so the setuptools egg is added to
	# the module search path
	insinto /usr/lib/python${PYVER}/site-packages
	echo "${MY_P}-py${PYVER}.egg" > "${MY_P}-py${PYVER}.pth"
	doins "${MY_P}-py${PYVER}.pth"
}

