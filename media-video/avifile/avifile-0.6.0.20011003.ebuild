# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.6.0.20011003.ebuild,v 1.1 2001/10/05 11:34:17 achim Exp $

P=${PN}-0.6.0-20011003
S=${WORKDIR}/${PN}-0.6.0
DESCRIPTION="Library for AVI-Files"

SRC_URI="http://avifile.sourceforge.net/${P}.tgz
	 http://avifile.sourceforge.net/binaries-011002.tgz"

HOMEPAGE="http://divx.euro.ru/"

DEPEND="virtual/glibc qt? ( >=x11-libs/qt-x11-2.2.2 ) >=media-libs/libsdl-1.1.5  app-arch/unzip"
RDEPEND="virtual/glibc qt? ( >=x11-libs/qt-x11-2.2.2 ) >=media-libs/libsdl-1.1.5"

src_unpack() {
  unpack ${P}.tgz
}

src_compile() {
    local myconf
    if [ -z "`use qt`" ] ; then
      myconf="$myconf --disable-qt"
    else
      myconf="$myconf --with-qt-includes=$QTDIR/include --with-qt-libraries=$QTDIR/lib"
    fi
    if [ "`use nas`" ] ; then
	LDFLAGS="-L/usr/X11R6/lib -lXt"
    fi
    export CFLAGS=${CFLAGS/-O?/-O2}
    try LDFLAGS="$LDFLAGS" ./configure --prefix=/usr/X11R6 --host=${CHOST} \
	--enable-quiet --disable-tsc $myconf
#    cp Makefile Makefile.orig
#    sed -e "s:/usr/lib/win32:${D}/usr/lib/win32:" \
#	Makefile.orig > Makefile
    try make
}

src_install () {

    dodir /usr/X11R6/lib /usr/X11R6/bin
    dodir /usr/lib/win32

    make prefix=${D}/usr/X11R6 install

    cd ${D}/usr/lib/win32
    unzip ${DISTDIR}/binaries-011002.zip
    cd ${S}
    dodoc COPYING README
    cd doc
    dodoc CREDITS EXCEPTIONS FreeBSD LICENSING TODO
    dodoc VIDEO-PERFORMANCE WARNINGS
}





