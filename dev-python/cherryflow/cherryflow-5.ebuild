# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherryflow/cherryflow-5.ebuild,v 1.7 2009/02/15 22:04:10 patrick Exp $

inherit distutils

DESCRIPTION="CherryFlow is a continuations framework for working with CherryPy"
HOMEPAGE="http://subway.python-hosting.com/wiki/CherryFlow"
SRC_URI="http://gentooexperimental.org/~pythonhead/dist/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""
RDEPEND="virtual/python"
DEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}
	doins devworksexample.py example.py wikiexample.py
}
