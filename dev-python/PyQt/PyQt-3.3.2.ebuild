# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.3.2.ebuild,v 1.2 2002/08/13 02:41:27 verwilst Exp $

S="${WORKDIR}/PyQt-snapshot-20020722"
DESCRIPTION="PyQt is a set of Python bindings for the Qt Toolkit( VERSION 3.x ONLY!!)."
SRC_URI="http://www.riverbankcomputing.co.uk/download/snapshots/PyQt/PyQt-snapshot-20020722.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pyqt/"
SLOT="0"
LICENSE="MIT"
KEYWORDS="x86"
DEPEND="virtual/glibc
	sys-devel/libtool
	>=x11-libs/qt-3.0.4.1
    	>=dev-lang/python-2.2.1
    	=dev-python/sip-3.3.2"

src_compile() {

	# Fix for one installation problem. The libtool included with the
	# source package does not have the relink patch.
	# Use the system libtool instead.
	cd ${S}
	mkdir -p ${D}/usr/lib/python2.2/site-packages
	mkdir -p ${D}/usr/include/python2.2
	python build.py \
	-d ${D}/usr/lib/python2.2/site-packages \
	-b ${D}/usr/bin \
	-l qt-mt -c
	make
}

src_install() {

	make DESTDIR=${D} install || die
	make DESTDIR=${D} install-eric || die
	echo "#!/bin/sh" > ${D}/usr/bin/eric
	echo " " >> ${D}/usr/bin/eric
	echo "exec python /usr/lib/python2.2/site-packages/eric/eric.py $*" >> ${D}/usr/bin/eric 
	chmod +x ${D}/usr/bin/eric
	mkdir -p ${D}/usr/share/doc/${P}/
	mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${P}/ 
	
}


