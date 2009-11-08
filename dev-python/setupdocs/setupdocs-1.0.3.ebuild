# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/setupdocs/setupdocs-1.0.3.ebuild,v 1.5 2009/11/08 19:53:13 nixnut Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="SetupDocs"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="setuptools plugin to automate building of docs from ReST source"
HOMEPAGE="http://pypi.python.org/pypi/SetupDocs http://code.enthought.com/projects/"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="amd64 ppc x86"
LICENSE="BSD"
DEPEND="dev-python/setuptools
	>=dev-python/sphinx-0.5.1"

RDEPEND=">=dev-python/sphinx-0.5.1
	virtual/latex-base
	|| ( dev-texlive/texlive-latexextra app-text/ptex )"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"
