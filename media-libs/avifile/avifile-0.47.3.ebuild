# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/avifile/avifile-0.47.3.ebuild,v 1.1 2000/09/19 01:19:46 achim Exp $

A="${P}.tar.gz binaries.zip"
S=${WORKDIR}/${P}
DESCRIPTION="Library for AVI-Files"
SRC_URI="http://divx.euro.ru/${P}.tar.gz
	 http://divx.euro.ru/binaries.zip"

HOMEPAGE="http://divx.euro.ru/"

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

    cp ${FILESDIR}/capproc.cpp ${S}/samples/qtvidcap

}

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 --host=${CHOST} 
    try make
    cd xmps-avi-plugin
    try make

}

src_install () {

    cd ${S}
    dodir /usr/X11R6/lib /usr/X11R6/bin
    try make prefix=${D}/usr/X11R6 install

    cd xmps-avi-plugin
    insinto /usr/X11R6/lib/xmps/Codecs
    insopts -m755
    doins libavi.so

    dodir /usr/libexec/avifile/win32
    cd ${D}/usr/libexec/avifile/win32
    unzip ${DISTDIR}/binaries.zip
    cd ${S}
    dodoc COPYING README
    cd doc
    dodoc CREDITS EXCEPTIONS FreeBSD LICENSING TODO
    dodoc VIDEO-PERFORMANCE WARNINGS
}




