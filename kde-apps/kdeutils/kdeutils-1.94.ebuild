# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kdeutils/kdeutils-1.94.ebuild,v 1.2 2000/10/06 01:12:13 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE 2 Final Beta - base"
SRC_URI="ftp://ftp.kde.org/pub/kde/unstable/distribution/2.0Beta5/tar/src/${A}
	 http://download.sourceforge.net/mirrors/kde/unstable/distribution/2.0Beta5/tar/src/${A}"
HOMEPAGE="http://www.kde.org/"

src_compile() {
    try ./configure --prefix=/opt/kde --host=${CHOST} \
                --with-qt-dir=/usr/lib/qt-x11-2.2.0 \
                --with-qt-includes=/usr/lib/qt-x11-2.2.0/include \
                --with-qt-libs=/usr/lib/qt-x11-2.2.0/lib
    try make
}

src_install() {
  try make install prefix=${D}/opt/kde
  dodoc AUTHORS COPYING README
}
