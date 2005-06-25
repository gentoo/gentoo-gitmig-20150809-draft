# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycurl/pycurl-7.13.2.ebuild,v 1.2 2005/06/25 15:06:05 liquidx Exp $

inherit distutils

DESCRIPTION="python binding for curl/libcurl"
HOMEPAGE="http://pycurl.sourceforge.net/"
SRC_URI="http://pycurl.sourceforge.net/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND="virtual/python
	>=net-misc/curl-${PV}"

PYTHON_MODNAME="curl"

src_install(){
	DOCS="TODO"
	distutils_src_install
	mv ${D}/usr/share/doc/pycurl/examples ${D}/usr/share/doc/${PF}
	mv ${D}/usr/share/doc/pycurl/html ${D}/usr/share/doc/${PF}
	mv ${D}/usr/share/doc/pycurl/tests ${D}/usr/share/doc/${PF}
	rm -fr ${D}/usr/share/doc/pycurl
}
