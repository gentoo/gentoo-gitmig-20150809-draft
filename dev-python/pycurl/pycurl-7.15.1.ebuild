# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycurl/pycurl-7.15.1.ebuild,v 1.1 2006/02/23 09:01:19 lucass Exp $

inherit distutils

DESCRIPTION="python binding for curl/libcurl"
HOMEPAGE="http://pycurl.sourceforge.net/"
SRC_URI="http://pycurl.sourceforge.net/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
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
