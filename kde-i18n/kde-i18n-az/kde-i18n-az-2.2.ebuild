# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-i18n/kde-i18n-az/kde-i18n-az-2.2.ebuild,v 1.1 2001/08/16 22:39:54 achim Exp $

V=2.2
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}
DESCRIPTION="KDE ${V} - i18n"
SRC_PATH="kde/stable/${V}/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${V}"
RDEPEND=">=kde-base/kdelibs-${V}"

PROVIDE="virtual/kde-i18n-${PV}"

src_compile() {

    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=${KDEDIR} --host=${CHOST} \
		--with-qt-dir=$QTBASE
    try make
}

src_install() {
  try make install DESTDIR=${D}
}


