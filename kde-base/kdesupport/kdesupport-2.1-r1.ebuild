# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesupport/kdesupport-2.1-r1.ebuild,v 1.2 2001/04/19 02:30:06 achim Exp $

V=2.1
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}-${V}
DESCRIPTION="KDE 2.1 - support"
SRC_PATH="kde/stable/2.1/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.twoguys.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=sys-devel/gcc-2.95.2
	>=x11-libs/qt-x11-2.2.3"

RDEPEND=">=sys-devel/gcc-2.95.2
         =kde-base/kde-env-2.1"


src_compile() {
    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=/opt/kde${V} --host=${CHOST} --enable-threads \
		--without-audiofile --with-qt-dir=$QTBASE
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS ChangeLog COPYING README
}


