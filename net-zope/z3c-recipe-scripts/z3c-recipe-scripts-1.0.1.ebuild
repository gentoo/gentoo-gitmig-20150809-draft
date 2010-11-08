# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/z3c-recipe-scripts/z3c-recipe-scripts-1.0.1.ebuild,v 1.1 2010/11/08 16:30:42 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Recipe for installing Python scripts"
HOMEPAGE="http://pypi.python.org/pypi/z3c.recipe.scripts"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools
	>=net-zope/zc-buildout-1.5.0
	>=net-zope/zc-recipe-egg-1.3.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt src/z3c/recipe/scripts/*.txt"
PYTHON_MODNAME="${PN//-//}"
