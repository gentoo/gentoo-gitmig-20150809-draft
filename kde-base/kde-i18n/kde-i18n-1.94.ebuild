# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-1.94.ebuild,v 1.4 2000/10/23 11:27:15 achim Exp $

A=kde-i18n.tar.bz2
S=${WORKDIR}/kde-i18n
DESCRIPTION="KDE 2Beta - libs"
SRC_URI="ftp://ftp.kde.org/pub/kde/unstable/distribution/2.0Beta5/tar/src/${A}
	 http://download.sourceforge.net/mirrors/kde/unstable/distribution/2.0Beta5/tar/src/${A}"
HOMEPAGE="http://www.kde.org/"

src_unpack () {
  unpack ${A}
  cd ${S}
  rm -r ca

}
src_compile() {
    try ./configure --prefix=/opt/kde2 --host=${CHOST} --with-ssl-dir=/usr \
		--with-qt-dir=/usr/lib/qt-x11-2.2.0 \
		--with-qt-includes=/usr/lib/qt-x11-2.2.0/include \
		--with-qt-libs=/usr/lib/qt-x11-2.2.0/lib
    cp Makefile Makefile.orig
    sed -e "s:br ca cy:br cy:" Makefile.orig > Makefile
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc COPYING highscore
  docinto html
  dodoc highscore.html
}



