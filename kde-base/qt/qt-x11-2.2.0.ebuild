# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/qt/qt-x11-2.2.0.ebuild,v 1.1 2000/09/17 11:50:18 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/qt-2.2.0
DESCRIPTION="QT 2.2"
SRC_URI="ftp://ftp.sourceforge.net/pub/mirrors/kde/unstable/distribution/2.0Beta5/tar/src/"${A}
HOMEPAGE="http://www.kde.org/"

export QTDIR=${S}
src_unpack() {
  unpack ${A}
  cd ${S}
  cp configure configure.orig
  sed -e "s:read acceptance:acceptance=yes:" configure.orig > configure
}
src_compile() {
    cd ${S}
    try ./configure -sm -thread -system-zlib -system-jpeg -system-libmng -qt-libpng -gif
    cd ${S}/src
    cp Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}/tools
    cp Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}/src/moc
    cp Makefile Makefile.orig
    sed -e "s/-pipe -O2/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}
    try make symlinks src-moc src-mt sub-src sub-tools
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
	cd ${D}/usr/lib
 	dosym   qt-x11-2.2.0 qt
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
	docinto doc/html/designer
	dodoc doc/html/designer
}




