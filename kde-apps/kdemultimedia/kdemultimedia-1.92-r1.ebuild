# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kdemultimedia/kdemultimedia-1.92-r1.ebuild,v 1.2 2000/08/16 04:38:05 drobbins Exp $

P=kdemultimedia-1.92
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE 2Beta - Multimedia"
SRC_URI="ftp://ftp.kde.org/pub/kde/unstable/distribution/2.0Beta3/tar/src/"${A}
HOMEPAGE="http://www.kde.org"

src_compile() {
    CPPFLAGS="$CPPFLAGS -I/usr/lib/glib/include/ -I/usr/X11R6/include/" \
    LDFLAGS="-L/usr/lib/rpm -lbz2" ./configure --prefix=/opt/kde --host=${CHOST} \
		--with-qt-dir=/usr/lib/qt-copy-1.92 \
		--with-qt-includes=/usr/lib/qt-copy-1.92/include \
		--with-qt-libs=/usr/lib/qt-copy-1.92/lib \
		--with-alsa --enable-audio=alsa,oss
    cp Makefile Makefile.orig
    sed -e "s: kmidi : :" \
	-e "s: mpeglib_artsplug : :" Makefile.orig > Makefile
    make
}

src_install() {
  make install prefix=${D}/opt/kde
  dodoc AUTHORS ChangeLog COPYING README*
}







