# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherryflow/cherryflow-5.ebuild,v 1.4 2006/03/19 22:47:25 halcy0n Exp $

inherit distutils

DESCRIPTION="CherryFlow is a continuations framework for working with CherryPy"
HOMEPAGE="http://www.cherrypy.org/attachment/wiki/CherryFlow/"
SRC_URI="http://gentooexperimental.org/~pythonhead/dist/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="virtual/python"
DEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	distutils_python_version
	distutils_src_install
	dodir /usr/share/doc/${P}
	cp devworksexample.py example.py wikiexample.py \
		${D}/usr/share/doc/${P}
}
