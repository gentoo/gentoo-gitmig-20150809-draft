# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxpython-docs/wxpython-docs-2.4.0.7.ebuild,v 1.3 2003/09/10 22:24:19 msterret Exp $

MY_P="${P/wxpython-docs/wxPythonDocs}"
DESCRIPTION="wxPython documentation"
HOMEPAGE="http://www.wxpython.org"
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.gz"

LICENSE="wxWinFDL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

# NOTE: rename to "wxpython" (lowercase) when we rename dev-python/wxPython
S="${WORKDIR}/${MY_P}"
DOCDIR="wxPython-${PVR}"

src_install() {
	dodir /usr/share/doc/${DOCDIR}
	dodir /usr/share/doc/${DOCDIR}/docs
	cp -R ${WORKDIR}/${DOCDIR}/docs/* ${D}/usr/share/doc/${DOCDIR}/docs/
}
