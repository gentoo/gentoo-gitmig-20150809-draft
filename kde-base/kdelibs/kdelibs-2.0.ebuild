# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-2.0.ebuild,v 1.4 2000/12/09 06:26:45 drobbins Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE 2.0 - libs"
SRC_PATH="kde/stable/2.0/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.twoguys.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=sys-devel/gcc-2.95.2
	>=dev-libs/openssl-0.9.6
	>=media-libs/audiofile-0.1.9
	>=media-libs/tiff-3.5.5
	>=kde-base/qt-2.2.1"

RDEPEND=">=sys-devel-gcc-2.95.2
	 >=media-libs/audiofile-0.1.9
	 >=kde-base/qt-2.2.1"

src_unpack() {
  unpack ${A}
}

src_compile() {
    try ./configure --prefix=/opt/kde2 --host=${CHOST} --with-ssl-dir=/usr \
		--with-qt-dir=/usr/lib/qt \
		--with-qt-includes=/usr/lib/qt/include \
		--with-qt-libs=/usr/lib/qt/lib
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS ChangeLog COMPILING COPYING* NAMING NEWS README
  docinto html
  dodoc *.html
}


