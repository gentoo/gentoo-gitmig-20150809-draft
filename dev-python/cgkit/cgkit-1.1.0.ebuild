# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cgkit/cgkit-1.1.0.ebuild,v 1.2 2004/08/03 11:34:41 dholm Exp $

inherit distutils

DESCRIPTION="Python library for creating 3D images"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip
	mirror://sourceforge/${PN}/${P}.doc.zip"
HOMEPAGE="http://cgkit.sourceforge.net"
DEPEND="dev-lang/python
	dev-python/pyrex"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

src_install () {
	distutils_src_install
	if use doc; then
		cd ${WORKDIR}
		dohtml *.html
		cp -ar pics ${D}/usr/share/doc/${PF}/html/
		cd ${S}/examples
		for example in *; do
			dodir /usr/share/${P}/examples/${example}
			exeinto /usr/share/${P}/examples/${example}
			doexe ${example}/*.py
		done
	fi
}
