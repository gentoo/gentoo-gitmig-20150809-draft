# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-2.1_beta1.ebuild,v 1.1 2000/12/21 19:16:37 achim Exp $

V=2.1beta1
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE 2.1 - libs"
SRC_PATH="kde/unstable/distribution/${V}/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.twoguys.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=sys-devel/gcc-2.95.2
	>=dev-libs/openssl-0.9.6
	>=media-libs/audiofile-0.1.9
	>=media-libs/tiff-3.5.5
	>=x11-libs/qt-x11-2.2.3"

RDEPEND=">=sys-devel/gcc-2.95.2
	 >=media-libs/audiofile-0.1.9
	 >=x11-libs/qt-x11-2.2.3"

src_unpack() {
  unpack ${A}
}

src_compile() {
    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=/opt/kde2 --host=${CHOST} --with-ssl-dir=/usr \
		--with-qt-dir=$QTBASE
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS ChangeLog COMPILING COPYING* NAMING NEWS README
  docinto html
  dodoc *.html
}


