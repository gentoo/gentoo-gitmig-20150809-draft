# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.6.0.20011026.ebuild,v 1.2 2001/12/29 17:41:37 danarmak Exp $

P0=${PN}-0.6.0-20011026
S=${WORKDIR}/${PN}0.6-0.6.4
DESCRIPTION="Library for AVI-Files"

SRC_URI="http://avifile.sourceforge.net/${P0}.tgz
	 http://avifile.sourceforge.net/binaries-011002.tgz"

HOMEPAGE="http://divx.euro.ru/"

DEPEND="virtual/glibc qt? ( >=x11-libs/qt-2.2.2 ) >=media-libs/libsdl-1.1.5  app-arch/unzip >=media-libs/divx4linux-20011025"
RDEPEND="virtual/glibc qt? ( >=x11-libs/qt-2.2.2 ) >=media-libs/libsdl-1.1.5 >=media-libs/divx4linux-20011025"

src_unpack() {
  unpack ${P0}.tgz
  patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}

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
    export LDFLAGS
    ./configure --prefix=/usr --host=${CHOST} \
	--enable-quiet --disable-tsc $myconf || die
#    cp Makefile Makefile.orig
#    sed -e "s:/usr/lib/win32:${D}/usr/lib/win32:" \
#	Makefile.orig > Makefile
    make || die
}

src_install () {

    dodir /usr/lib /usr/bin
    dodir /usr/lib/win32

    make prefix=${D}/usr install

    cd ${D}/usr/lib/win32
    unzip ${DISTDIR}/binaries-011002.zip
    cd ${S}
    dodoc COPYING README
    cd doc
    dodoc CREDITS EXCEPTIONS FreeBSD LICENSING TODO
    dodoc VIDEO-PERFORMANCE WARNINGS
}





