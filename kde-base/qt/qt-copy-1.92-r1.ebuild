# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/qt/qt-copy-1.92-r1.ebuild,v 1.3 2000/09/15 20:09:00 drobbins Exp $

P=qt-copy-1.92
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="QT 2.2"
SRC_URI="ftp://ftp.kde.org/pub/kde/unstable/distribution/2.0Beta3/tar/src/"${A}
HOMEPAGE="http://www.kde.org/"

export QTDIR=${S}

src_compile() {
   cd ${S}
    try ./configure -sm -thread -system-zlib -system-jpeg -qt-libpng -gif
    cd ${S}/src
    cp Makefile Makefile.orig
    sed -e "s/-pipe -O2/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}/src/moc
    cp Makefile Makefile.orig
    sed -e "s/-pipe -O2/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}
    try make moc src
}

src_install() {                 
	cd ${S}
	dodir /usr/lib/${P}
	into /usr/lib/${P}
	dobin bin/*
	dolib.so lib/libqt.so.2.2.0
	cd ${S}/lib
	dosym	libqt.so.2.2.0 /usr/lib/${P}/lib/libqt.so.2.2
	dosym	libqt.so.2.2.0 /usr/lib/${P}/lib/libqt.so.2
	dosym	libqt.so.2.2.0 /usr/lib/${P}/lib/libqt.so
	cd ${S}
	cp -a include ${D}/usr/lib/${P}/
	cp -a extensions ${D}/usr/lib/${P}/
	cd src
	try make clean
	cd ..
	cp -a src ${D}/usr/lib/${P}/
	into /usr
	doman doc/man/man3/*
      
	dodoc ANNOUNCE FAQ LICENSE.QPL MANIFEST PLATFORMS
	dodoc PORTING README* 
        docinto html
	dodoc doc/html/*
}




