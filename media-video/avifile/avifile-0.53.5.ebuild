# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.53.5.ebuild,v 1.3 2001/05/15 15:41:32 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Library for AVI-Files"
SRC_URI="http://divx.euro.ru/${P}.tar.gz
	 http://divx.euro.ru/binaries-010122.zip"

HOMEPAGE="http://divx.euro.ru/"

DEPEND=">=x11-libs/qt-x11-2.2.2"
RDEPEND=">=x11-libs/qt-x11-2.2.2
	 >=media-libs/libsdl-1.1.5
	 >=x11-libs/gtk+-1.2.8
	 >=media-sound/esound-0.2.19"
	

src_compile() {
    if [ "`use nas`" ] ; then
	LDFLAGS="-L/usr/X11R6/lib -lXt"
    fi
    export CFLAGS=${CFLAGS/-O?/-O2}
    try LDFLAGS=\"$LDFLAGS\" ./configure --prefix=/usr/X11R6 --host=${CHOST} --disable-tsc
    cp Makefile Makefile.orig
    sed -e "s:/usr/lib/win32:${D}/usr/lib/win32:" \
	Makefile.orig > Makefile
    try make
    cd xmps-avi-plugin
    cp Makefile Makefile.orig
    sed -e "s:INCLUDES = :INCLUDES = -I/usr/X11R6/include -I/usr/include/glib/include -I/opt/gnome/include:" \
    	Makefile.orig > Makefile
    try make

}

src_install () {

    dodir /usr/X11R6/lib /usr/X11R6/bin
    dodir /usr/lib/win32

    make prefix=${D}/usr/X11R6 install

    cd ${D}/usr/lib/win32
    unzip ${DISTDIR}/binaries-010122.zip
    cd ${S}
    dodoc COPYING README
    cd doc
    dodoc CREDITS EXCEPTIONS FreeBSD LICENSING TODO
    dodoc VIDEO-PERFORMANCE WARNINGS
}





