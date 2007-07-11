# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xsv/xsv-2.7.ebuild,v 1.5 2007/07/11 06:19:47 mr_bones_ Exp $

inherit distutils

MY_P=${P/xsv/XSV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Python XML Schema Validator"
SRC_URI="ftp://ftp.cogsci.ed.ac.uk/pub/XSV/${MY_P}.tar.gz"
HOMEPAGE="http://www.ltg.ed.ac.uk/~ht/xsv-status.html"

KEYWORDS="~ppc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2
	>=dev-python/pyltxml-1.3"

src_install() {
	distutils_src_install
	distutils_python_version
	dodoc xsv-status.xml pc-shrinkwrap
	dohtml xsv-status.html
	rm -rf ${D}/usr/lib/python${PYVER}/site-packages/XSV/doc
	mv ${D}/usr/lib/python${PYVER}/site-packages/XSV/example ${D}/usr/share/doc/${PF}
}
