# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Ollie Rutherfurd <oliver@rutherfurd.net>
# $Header: /var/cvsroot/gentoo-x86/dev-python/4Suite/4Suite-0.11.1_beta3.ebuild,v 1.1 2001/08/05 03:13:23 kabau Exp $

A="4Suite-0.11.1b3.tar.gz"
S=${WORKDIR}"/4Suite-0.11.1b3"
DESCRIPTION="Python tools for XML processing and object-databases."
SRC_URI="ftp://ftp.fourthought.com/pub/4Suite/"${A}
HOMEPAGE="http://www.4suite.org/"

DEPEND="virtual/python
		=dev-python/PyXML-0.6.5"

src_compile() {
	cd ${S}
	try python setup.py build
}

src_install() {
	cd ${S}
	try python setup.py install --prefix=${D}/usr
	dodoc README*
	dodoc ReleaseNotes
}
