# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.51.ebuild,v 1.1 2000/12/17 20:09:02 achim Exp $

A="${P}.tar.gz binaries.zip"
S=${WORKDIR}/${P}
DESCRIPTION="Library for AVI-Files"
SRC_URI="http://divx.euro.ru/${P}.tar.gz
	 http://divx.euro.ru/binaries.zip"

HOMEPAGE="http://divx.euro.ru/"

DEPEND=">=x11-libs/qt-x11-2.2.2"
RDEPEND=">=x11-libs/qt-x11-2.2.2
	 >=media-libs/libsdl-1.1.5
	 >=x11-libs/gtk+-1.2.8
	 >=media-sound/esound-0.2.19"
	
src_unpack () {

    WIN32=/usr/libexec/avifile/win32

    unpack ${P}.tar.gz

    cd ${S}

    cp configure configure.orig
    sed -e "s:/usr/lib/win32:$WIN32:" configure.orig > configure


    cd ${S}/lib/loader

    cp elfdll.c elfdll.c.orig
    sed -e "s:/usr/lib/win32:$WIN32:" elfdll.c.orig > elfdll.c

    cd ../audiodecoder

    cp audiodecoder.cpp audiodecoder.cpp.orig
    sed -e "s:/usr/lib/win32:$WIN32:" audiodecoder.cpp.orig > audiodecoder.cpp

    cd ${S}/player

    cp mywidget.cpp mywidget.cpp.orig
    sed -e "s:/usr/lib/win32:$WIN32:" mywidget.cpp.orig > mywidget.cpp


}

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 --host=${CHOST} --disable-tsc
    cp Makefile Makefile.orig
    sed -e "s:/usr/libexec/avifile/win32:${D}/usr/libexec/avifile/win32:" \
	Makefile.orig > Makefile
    try make
    cd xmps-avi-plugin
    cp Makefile Makefile.orig
    sed -e "s:INCLUDES = :INCLUDES = -I/usr/X11R6/include -I/usr/include/glib/include -I/opt/gnome/include:" \
    	Makefile.orig > Makefile
    try make

}

src_install () {

    cd ${S}
    dodir /usr/X11R6/lib /usr/X11R6/bin
    dodir /usr/libexec/avifile/win32

    make prefix=${D}/usr/X11R6 install

    cd ${D}/usr/libexec/avifile/win32
    unzip ${DISTDIR}/binaries.zip
    cd ${S}
    dodoc COPYING README
    cd doc
    dodoc CREDITS EXCEPTIONS FreeBSD LICENSING TODO
    dodoc VIDEO-PERFORMANCE WARNINGS
}





