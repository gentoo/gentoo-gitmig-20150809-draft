# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kde-i18n-de/kde-i18n-de-2.1.ebuild,v 1.1 2001/04/27 20:34:34 drobbins Exp $

V=2.1
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}
DESCRIPTION="KDE 2.1 Beta 2 - i18n"
SRC_PATH="kde/stable/2.1/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.twoguys.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${V}"
PROVIDE="virtual/kde-i18n-${V}"

src_compile() {

    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=/opt/kde${V} --host=${CHOST} \
		--with-qt-dir=$QTBASE
    try make
}

src_install() {
  try make install DESTDIR=${D}
}


