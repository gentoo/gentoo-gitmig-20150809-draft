# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-1.94.ebuild,v 1.1 2000/09/17 12:15:08 achim Exp $

A="${P}.tar.bz2"
S=${WORKDIR}/${P}
DESCRIPTION="KDE 2 FinalBeta - base"
SRC_URI="ftp://ftp.sourceforge.net/pub/mirrors/kde/unstable/distribution/2.0Beta5/tar/src/${P}.tar.bz2"
HOMEPAGE="http://www.kde.org/"

src_compile() {

    export CFLAGS="${CFLAGS} -I/usr/X11R6/include"
    export CXXFLAGS="${CXXFLAGS} -I/usr/X11R6/include"
    export CPPFLAGS="${CXXFLAGS} -I/usr/X11R6/include"
    try ./configure --prefix=/opt/kde --host=${CHOST} --with-shadow --with-x \
		--with-pam=yes --with-ldap \
		--with-qt-dir=/usr/lib/qt-x11-2.2.0 \
		--with-qt-includes=/usr/lib/qt-x11-2.2.0/include \
		--with-qt-libs=/usr/lib/qt-x11-2.2.0/lib
    try make
}


src_install() {
  try make install prefix=${D}/opt/kde
  dodoc AUTHORS ChangeLog README*
}

