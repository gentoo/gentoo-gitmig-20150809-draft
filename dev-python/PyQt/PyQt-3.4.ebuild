# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.4.ebuild,v 1.1 2002/09/17 17:24:11 verwilst Exp $

S="${WORKDIR}/PyQt-x11-gpl-${PV}"
DESCRIPTION="PyQt is a set of Python bindings for the QT 3.x Toolkit"
SRC_URI="http://www.river-bank.demon.co.uk/download/PyQt/PyQt-x11-gpl-${PV}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pyqt/"
SLOT="0"
LICENSE="MIT"
KEYWORDS="x86 sparc sparc64"
DEPEND="virtual/glibc
	sys-devel/libtool
	>=x11-libs/qt-3.0.4.1
    	>=dev-lang/python-2.2.1
    	=dev-python/sip-3.4"

src_compile() {

	cd ${S}
	mkdir -p ${D}/usr/lib/python2.2/site-packages
	mkdir -p ${D}/usr/include/python2.2
	python build.py \
	-d ${D}/usr/lib/python2.2/site-packages \
	-e /usr/include/python2.2 \
	-b ${D}/usr/bin \
	-l qt-mt -c
	make
}

src_install() {

	make DESTDIR=${D} install || die
	make DESTDIR=${D} install-eric || die
	dodoc README.Linux NEWS LICENSE README ChangeLog THANKS
	echo "#!/bin/sh" > ${D}/usr/bin/eric
	echo " " >> ${D}/usr/bin/eric
	echo "exec python /usr/lib/python2.2/site-packages/eric/eric.py $*" >> ${D}/usr/bin/eric 
	chmod +x ${D}/usr/bin/eric
	mkdir -p ${D}/usr/share/doc/${P}/
	mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${P}/ 
	
}


