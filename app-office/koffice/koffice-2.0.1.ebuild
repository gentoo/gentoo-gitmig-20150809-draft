# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-2.0.1.ebuild,v 1.3 2001/03/29 23:57:34 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - KOffice"
SRC_PATH="kde/stable/${PV}/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV}"
RDEPEND=$DEPEND

src_compile() {
    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=$KDEDIR --host=${CHOST} \
		--with-qt-dir=$QTBASE
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc ChangeLog COPYING AUTHORS NEWS README
}

