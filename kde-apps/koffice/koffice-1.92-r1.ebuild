# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/koffice/koffice-1.92-r1.ebuild,v 1.3 2000/08/25 15:10:23 achim Exp $

P=koffice-1.92
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE 2Beta - KOffice"
SRC_URI="ftp://ftp.kde.org/pub/kde/unstable/distribution/2.0Beta3/tar/src/"${A}
HOMEPAGE="http://www.kde.org/"

src_compile() {
 
    ./configure --prefix=/opt/kde --host=${CHOST} \
		--with-qt-dir=/usr/lib/qt-copy-1.92 \
		--with-qt-includes=/usr/lib/qt-copy-1.92/include \
		--with-qt-libs=/usr/lib/qt-copy-1.92/lib
    make
}

src_install() {
  make install prefix=${D}/opt/kde
  dodoc ChangeLog COPYING AUTHORS NEWS README
}

