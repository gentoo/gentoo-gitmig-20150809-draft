# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Ollie Rutherfurd <oliver@rutherfurd.net>
# $Header: /var/cvsroot/gentoo-x86/dev-python/4Suite/4Suite-0.11.1_beta3.ebuild,v 1.2 2001/11/10 12:14:29 hallski Exp $

S=${WORKDIR}"/4Suite-0.11.1b3"
DESCRIPTION="Python tools for XML processing and object-databases."
SRC_URI="ftp://ftp.fourthought.com/pub/4Suite/4Suite-0.11.1b3.tar.gz"
HOMEPAGE="http://www.4suite.org/"

DEPEND="virtual/python
	=dev-python/PyXML-0.6.5"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --prefix=${D}/usr || die
	dodoc README* ReleaseNotes
}
