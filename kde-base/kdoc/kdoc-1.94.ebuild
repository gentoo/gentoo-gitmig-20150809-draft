# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdoc/kdoc-1.94.ebuild,v 1.1 2000/09/18 17:25:26 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE 2 Final Beta - Multimedia"
SRC_URI="http://download.sourceforge.net/mirrors/kde/unstable/distribution/2.0Beta5/tar/src/"${A}
HOMEPAGE="http://www.kde.org"

src_compile() {
    try autoconf
    LDFLAGS="-L/usr/lib/rpm -lbz2" try ./configure --prefix=/opt/kde --host=${CHOST} \
		--with-qt-dir=/usr/lib/qt-x11-2.2.0 \
		--with-qt-includes=/usr/lib/qt-x11-2.2.0/include \
		--with-qt-libs=/usr/lib/qt-x11-2.2.0/lib \
		--with-rpm --with-pam
    try make
}

src_install() {
  try make install prefix=${D}/opt/kde
  dodoc README TODO Version
  prepman /opt/kde
}









