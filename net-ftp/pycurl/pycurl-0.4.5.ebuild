# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pycurl/pycurl-0.4.5.ebuild,v 1.6 2002/10/04 06:04:25 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="python binding for curl/libcurl"
SRC_URI="mirror://sourceforge/pycurl/pycurl-0.4.5.tar.gz"
HOMEPAGE="http://pycurl.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=dev-lang/python-2.1.1
	>=net-ftp/curl-7.9.3"

src_install(){
	python setup.py install --prefix=${D}/usr || die
	dodoc README INSTALL COPYING TODO ChangeLog
}
