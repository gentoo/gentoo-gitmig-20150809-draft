# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdoc/kdoc-2.0_rc2.ebuild,v 1.1 2000/10/19 16:20:04 achim Exp $

P=${PN}-2.0rc2
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE 2 Final Beta - Multimedia"
SRC_URI="ftp://ftp.kde.org/pub/kde/unstable/distribution/2.0RC2/tar/src/${A}
	 http://download.sourceforge.net/mirrors/kde/unstable/distribution/2.0RC2/tar/src/${A}"

HOMEPAGE="http://www.kde.org"

src_compile() {
    try autoconf
    try ./configure --prefix=/opt/kde --host=${CHOST} \
		--with-qt-dir=/usr/lib/qt-x11-2.2.1 \
		--with-qt-includes=/usr/lib/qt-x11-2.2.1/include \
		--with-qt-libs=/usr/lib/qt-x11-2.2.1/lib \
		--with-rpm --with-pam
    try make
}

src_install() {

  dodir /opt/kde/man/man1
  try make install DESTDIR=${D}
  dodoc README TODO Version

}









