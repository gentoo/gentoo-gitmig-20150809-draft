# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kdoc/kdoc-2.1.1.ebuild,v 1.1 2001/04/28 15:38:51 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Documentation"
SRC_PATH="kde/stable/2.1.1/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org"

DEPEND=">=sys-devel/perl-5"
RDEPEND=$DEPEND

src_compile() {
    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=/opt/kde2.1 --mandir=/opt/kde2.1/share/man --host=${CHOST} \
		--with-qt-dir=$QTDIR
    try make
}

src_install() {

  dodir /opt/kde2/share/man/man1
  try make install DESTDIR=${D}
  dodoc README TODO Version

}









