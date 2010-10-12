# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/markupsafe/markupsafe-0.11.ebuild,v 1.3 2010/10/12 16:37:49 armin76 Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="MarkupSafe"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implements a XML/HTML/XHTML Markup safe string for Python"
HOMEPAGE="http://pypi.python.org/pypi/MarkupSafe"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DISTUTILS_GLOBAL_OPTIONS=("--with-speedups")

src_install() {
	distutils_src_install
	python_clean_installation_image
}
