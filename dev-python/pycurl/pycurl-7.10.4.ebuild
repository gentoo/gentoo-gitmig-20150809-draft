# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycurl/pycurl-7.10.4.ebuild,v 1.8 2004/03/29 00:46:44 vapier Exp $

inherit distutils

DESCRIPTION="python binding for curl/libcurl"
HOMEPAGE="http://pycurl.sourceforge.net/"
SRC_URI="http://pycurl.sourceforge.net/download/00-OLD-VERSIONS/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND=">=dev-lang/python-2.1.1
	>=net-misc/curl-${PV}"

src_install(){
	mydoc="TODO"
	distutils_src_install
	mv ${D}/usr/share/doc/pycurl/examples ${D}/usr/share/doc/${P}
	mv ${D}/usr/share/doc/pycurl/html ${D}/usr/share/doc/${P}
	mv ${D}/usr/share/doc/pycurl/tests ${D}/usr/share/doc/${P}
	rm -fr ${D}/usr/share/doc/pycurl
}
