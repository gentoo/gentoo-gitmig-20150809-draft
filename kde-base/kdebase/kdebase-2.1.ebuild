# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-2.1.ebuild,v 1.1 2001/02/28 01:45:35 drobbins Exp $

V="2.1"
S=${WORKDIR}/${PN}-${V}
DESCRIPTION="KDE 2.1 - Base"
SRC_PATH="kde/stable/distribution/${V}/tar/generic/src/${PN}-${V}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp://ftp.twoguys.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"
HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-2.1
	>=x11-libs/openmotif-2.1.30"

src_compile() {
    QTBASE=/usr/X11R6/lib/qt
    export CFLAGS="${CFLAGS} -I/usr/X11R6/include"
    export CXXFLAGS="${CXXFLAGS} -I/usr/X11R6/include"
    export CPPFLAGS="${CXXFLAGS} -I/usr/X11R6/include"
    try ./configure --prefix=/opt/kde${V} --host=${CHOST} --with-shadow --with-x \
		--with-pam=yes --with-ldap \
		--with-qt-dir=$QTBASE 
    try make
}


src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS ChangeLog README*
}


