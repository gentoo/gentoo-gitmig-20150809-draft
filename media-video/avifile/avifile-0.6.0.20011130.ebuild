# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/media-video/avifile/avifile-0.6.0.20011109.ebuild,v 1.4 2001/11/15 14:30:14 achim Exp

A=${PN}-0.6.0-20011130
S=${WORKDIR}/${P}
DESCRIPTION="Library for AVI-Files"

SRC_URI="http://avifile.sourceforge.net/${A}.tgz"

HOMEPAGE="http://divx.euro.ru/"

DEPEND="media-libs/win32codecs
	>=media-libs/libsdl-1.2.2
	>=media-libs/divx4linux-20011025
	qt? ( >=x11-libs/qt-2 )
	nas? ( >=media-libs/nas-1.4.2 )"

src_compile() {
    local myconf
    if [ -z "`use qt`" ] ; then
      myconf="$myconf --disable-qt"
    else
      myconf="$myconf --with-qt-dir=/usr/qt/2"
    fi
    if [ "`use nas`" ] ; then
	LDFLAGS="-L/usr/X11R6/lib -lXt"
    fi
    export CFLAGS=${CFLAGS/-O?/-O2}
    LDFLAGS="$LDFLAGS -L/usr/kde/2/lib"
    export LDFLAGS
    ./configure --prefix=/usr --host=${CHOST} \
	--enable-quiet --disable-tsc --with-extra-libraries=/usr/kde/2 $myconf || die
#    cp Makefile Makefile.orig
#    sed -e "s:/usr/lib/win32:${D}/usr/lib/win32:" \
#	Makefile.orig > Makefile
    make || die
}

src_install () {

    dodir /usr/lib /usr/bin
    dodir /usr/lib/win32

    make prefix=${D}/usr install || die

    cd ${S}
    dodoc COPYING README
    cd doc
    dodoc CREDITS EXCEPTIONS FreeBSD LICENSING TODO
    dodoc VIDEO-PERFORMANCE WARNINGS
}
