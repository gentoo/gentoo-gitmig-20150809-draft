# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-1.92-r1.ebuild,v 1.3 2000/09/15 20:08:59 drobbins Exp $

P=kde-i18n-1.92
A=kde-i18n.tar.bz2
S=${WORKDIR}/kde-i18n
DESCRIPTION="KDE 2Beta - libs"
SRC_URI="ftp://ftp.kde.org/pub/kde/unstable/distribution/2.0Beta3/tar/src/"${A}
HOMEPAGE="http://www.kde.org/"

src_compile() {
    try ./configure --prefix=/opt/kde --host=${CHOST} --with-ssl-dir=/usr \
		--with-qt-dir=/usr/lib/qt-2.1.1 \
		--with-qt-includes=/usr/lib/qt-copy-1.92/include \
		--with-qt-libs=/usr/lib/qt-copy-1.92/lib
    try make
}

src_install() {                 
  try make install prefix=${D}/opt/kde bindir=${D}/opt/kde/bin
  dodoc COPYING highscore
  docinto html
  dodoc highscore.html
}



