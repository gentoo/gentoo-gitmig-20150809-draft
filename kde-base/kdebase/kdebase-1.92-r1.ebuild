# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-1.92-r1.ebuild,v 1.2 2000/08/16 04:38:06 drobbins Exp $

P=kdebase-1.92
A="${P}.tar.bz2"
S=${WORKDIR}/${P}
DESCRIPTION="KDE 2Beta - base"
SRC_URI="ftp://ftp.kde.org/pub/kde/unstable/distribution/2.0Beta3/tar/src/${P}.tar.bz2"
HOMEPAGE="http://www.kde.org/"

src_compile() {

    CFLAGS="${CFLAGS} -I/usr/X11R6/include"
    ./configure --prefix=/opt/kde --host=${CHOST} --with-shadow --with-x --with-pam \
		--with-qt-dir=/usr/lib/qt-copy-1.92 \
		--with-qt-includes=/usr/lib/qt-copy-1.92/include \
		--with-qt-libs=/usr/lib/qt-copy-1.92/lib
    make
}


src_install() {                 
  make install prefix=${D}/opt/kde
  dodoc AUTHORS ChangeLog README*
}

