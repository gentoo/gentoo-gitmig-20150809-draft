# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-1.94.ebuild,v 1.3 2000/10/05 18:22:51 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE 2 FinalBeta - libs"
SRC_URI="ftp://ftp.kde.org/pub/kde/unstable/distribution/2.0Beta5/tar/src/${A}
	 ftp://ftp.sourceforge.net/pub/mirrors/kde/unstable/distribution/2.0Beta5/tar/src/${A}"

HOMEPAGE="http://www.kde.org/"

src_unpack() {
  unpack ${A}
  cp ${FILESDIR}/ksslcertificate.cc ${S}/kssl
}

src_compile() {
    try ./configure --prefix=/opt/kde --host=${CHOST} --with-ssl-dir=/usr \
		--with-qt-dir=/usr/lib/qt-x11-2.2.0 \
		--with-qt-includes=/usr/lib/qt-x11-2.2.0/include \
		--with-qt-libs=/usr/lib/qt-x11-2.2.0/lib
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS ChangeLog COMPILING COPYING* NAMING NEWS README
  docinto html
  dodoc *.html
}


