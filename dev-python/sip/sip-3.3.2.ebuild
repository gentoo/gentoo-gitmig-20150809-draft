# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-3.3.2.ebuild,v 1.2 2002/08/16 02:49:58 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
SRC_URI="http://www.riverbankcomputing.co.uk/download/sip/${P}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"
SLOT="0"
LICENSE="MIT"
KEYWORDS="x86 sparc sparc64"
DEPEND="virtual/glibc
	>=dev-lang/python-2.2.1"

src_compile(){

	cd ${S}
	chmod +x build.py
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/lib/python2.2/site-packages
	python build.py -l qt-mt -b ${D}/usr/bin -d ${D}/usr/lib/python2.2/site-packages
	make
}

src_install() {

	cd ${S}/siplib
	mv Makefile Makefile.orig
	sed s:"cp sip.h /usr/include/python2.2":"cp sip.h /var/tmp/portage/sip-3.3.2/image/usr/include/python2.2": Makefile.orig > Makefile
	mv Makefile Makefile.orig2
	sed s:"cp sipQt.h /usr/include/python2.2":"cp sipQt.h /var/tmp/portage/sip-3.3.2/image/usr/include/python2.2": Makefile.orig2 > Makefile
	cd ${S} 
	mkdir -p ${D}/usr/include/python2.2 
	make DESTDIR=${D} install || die
	dodoc NEWS README THANKS

}
