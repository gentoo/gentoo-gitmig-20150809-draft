# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/qt/qt-2.2.1.ebuild,v 1.1 2000/12/09 06:26:45 drobbins Exp $

QP=${PN}-x11-${PV}
A=${QP}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="QT 2.2"
SRC_PATH="kde/stable/2.0/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"
HOMEPAGE="http://www.kde.org/"

DEPEND=">=media-libs/libpng-1.0.7
	>=media-libs/libmng-0.9.3
	>=media-sound/nas-1.4.1
	>=x11-base/xfree-4.0.1"

export QTDIR=${S}

src_unpack() {
  unpack ${A}
  cd ${S}
  cp configure configure.orig
  sed -e "s:read acceptance:acceptance=yes:" configure.orig > configure
}

src_compile() {
    cd ${S}
    export LDFLAGS="-ldl"
    ./configure -sm -thread -system-zlib -system-jpeg -system-nas-sound \
	-system-libmng -system-libpng -gif -platform linux-g++ -ldl -lpthread
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
	dodir /usr/lib/${QP}
	into /usr/lib/${QP}
	dobin bin/*
	dolib.so lib/libqt.so.${PV}
	dolib.so lib/libqt-mt.so.${PV}
	dolib.so lib/libqutil.so.1.0.0
	preplib /usr/lib/${QP}
	dosym	libqt.so.${PV} /usr/lib/${QP}/lib/libqt.so
	dosym   libqt-mt.so.${PV} /usr/lib/${QP}/lib/libqt-mt.so
	dosym   libqutil.so.1.0.0 /usr/lib/${QP}/lib/libqutil.so
	cd ${D}/usr/lib
 	ln -sf  ${QP} qt
	cd ${S}
	dodir /usr/lib/${P}/include
	cp include/* ${D}/usr/lib/${QP}/include/
#	cp -a extensions ${D}/usr/lib/${QP}/
#	cd src
#	try make clean
#	cd ..
#	cp -a src ${D}/usr/lib/${QP}/
#	into /usr
	doman doc/man/man3/*

	dodoc ANNOUNCE FAQ LICENSE.QPL MANIFEST PLATFORMS
	dodoc PORTING README*
        cp -af ${S}/doc/html ${D}/usr/doc/${P}

}




