# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherryflow/cherryflow-5.ebuild,v 1.1 2005/03/18 18:29:14 pythonhead Exp $

inherit distutils

DESCRIPTION="CherryFlow is a continuations framework for working with CherryPy"
HOMEPAGE="http://www.cherrypy.org/attachment/wiki/CherryFlow/"
SRC_URI="http://gentooexperimental.org/~pythonhead/dist/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/python"
IUSE=""

S=${WORKDIR}

src_install() {
	distutils_python_version
	distutils_src_install
	dodir /usr/share/docs/${P}
	cp devworksexample.py example.py wikiexample.py \
		${D}/usr/share/docs/${P}
}
