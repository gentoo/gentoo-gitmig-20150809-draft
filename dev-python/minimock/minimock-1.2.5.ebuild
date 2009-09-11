# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/minimock/minimock-1.2.5.ebuild,v 1.1 2009/09/11 12:45:07 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="MiniMock"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The simplest possible mock library"
HOMEPAGE="http://pypi.python.org/pypi/MiniMock"
SRC_URI="http://pypi.python.org/packages/source/M/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

DOCS="docs/changelog.txt docs/index.txt"

pkg_postinst() {
	python_mod_optimize minimock.py
}
