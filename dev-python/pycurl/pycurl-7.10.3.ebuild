# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycurl/pycurl-7.10.3.ebuild,v 1.1 2003/06/13 22:21:27 liquidx Exp $

inherit distutils

S=${WORKDIR}/${P}
DESCRIPTION="python binding for curl/libcurl"
SRC_URI="http://pycurl.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://pycurl.sourceforge.net"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~sparc"

DEPEND=">=dev-lang/python-2.1.1
		>=net-ftp/curl-${PV}"

src_install(){
	mydoc="TODO"
	distutils_src_install
	mv ${D}/usr/share/doc/pycurl/examples ${D}/usr/share/doc/${P}
	mv ${D}/usr/share/doc/pycurl/html ${D}/usr/share/doc/${P}
	mv ${D}/usr/share/doc/pycurl/tests ${D}/usr/share/doc/${P}
    rm -fr ${D}/usr/share/doc/pycurl
}
