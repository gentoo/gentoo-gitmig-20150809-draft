# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxpython-docs/wxpython-docs-2.4.2.4-r1.ebuild,v 1.1 2005/05/02 19:02:13 pythonhead Exp $

MY_P="${P/wxpython-docs/wxPythonDocs}"

DESCRIPTION="wxPython documentation"
HOMEPAGE="http://www.wxpython.org"
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.gz
	mirror://sourceforge/wxpython/wxPythonDemo-${PV}.tar.gz"

LICENSE="wxWinFDL-3 LGPL-2.1"
SLOT="2.4"
KEYWORDS="x86 ~sparc amd64"
IUSE=""

S="${WORKDIR}/wxPython-${PVR}"
DOCDIR="wxpython-${PVR}"

src_install() {
	dodir /usr/share/doc/${DOCDIR}/docs
	cp -R ${WORKDIR}/${DOCDIR}/docs/* ${D}/usr/share/doc/${DOCDIR}/docs/
	dodir /usr/share/doc/${DOCDIR}/demo
	dodir /usr/share/doc/${DOCDIR}/samples
	cp -R ${WORKDIR}/${DOCDIR}/demo/* ${D}/usr/share/doc/${DOCDIR}/demo/
	cp -R ${WORKDIR}/${DOCDIR}/samples/* ${D}/usr/share/doc/${DOCDIR}/samples/
}

pkg_postinst() {
	einfo "The demo files are now included with dev-python/wxpython-docs"
}
