# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/setupdocs/setupdocs-1.0.1.ebuild,v 1.1 2009/01/15 09:30:51 bicatali Exp $

inherit distutils

DESCRIPTION="setuptools plugin to automate building of docs from ReST source"
HOMEPAGE="http://pypi.python.org/pypi/setupdocs"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
DEPEND=">=dev-python/sphinx-0.5.1"
RDEPEND="${DEPEND}
	virtual/latex-base
	|| ( dev-texlive/texlive-latexextra app-text/tetex app-text/ptex )"
