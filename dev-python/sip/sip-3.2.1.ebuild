# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-3.2.1.ebuild,v 1.1 2002/05/05 17:18:11 verwilst Exp $


S=${WORKDIR}/${P}
DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
SRC_URI="http://www.riverbankcomputing.co.uk/download/sip/${P}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"
SLOT="0"

DEPEND="virtual/glibc
	>=dev-lang/python-2.2"

src_compile(){
	
	./configure --prefix=/usr || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING NEWS README THANKS TODO

}
