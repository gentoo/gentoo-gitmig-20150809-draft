# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joseph H. Yao <protrans@371.net>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pycurl/pycurl-0.4.5.ebuild,v 1.1 2002/01/30 13:24:58 gbevin Exp $

S=${WORKDIR}/${P}
DESCRIPTION="python binding for curl/libcurl"
SRC_URI="http://prdownloads.sourceforge.net/pycurl/pycurl-0.4.5.tar.gz"
HOMEPAGE="http://pycurl.sourceforge.net"

DEPEND=">=dev-lang/python-2.1.1
	>=net-ftp/curl-7.9.3"

src_install(){
	python setup.py install --prefix=${D}/usr || die
	dodoc README INSTALL COPYING TODO ChangeLog
}
