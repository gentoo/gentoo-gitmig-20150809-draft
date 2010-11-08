# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zc-recipe-testrunner/zc-recipe-testrunner-1.4.0.ebuild,v 1.1 2010/11/08 16:35:31 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="ZC Buildout recipe for creating test runners"
HOMEPAGE="http://pypi.python.org/pypi/zc.recipe.testrunner"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools
	net-zope/z3c-recipe-scripts
	>=net-zope/zc-buildout-1.5.0
	net-zope/zope-testrunner"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt src/zc/recipe/testrunner/*.txt"
PYTHON_MODNAME="${PN//-//}"
