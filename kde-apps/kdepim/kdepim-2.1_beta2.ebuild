# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kdepim/kdepim-2.1_beta2.ebuild,v 1.1 2001/01/31 20:49:06 achim Exp $

V=2.1-beta2
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}-${V}
DESCRIPTION="KDE ${PV} - PIM"
SRC_PATH="kde/unstable/distribution/2.1beta2/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http:/www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV}"
RDEPEND=$DEPEND

src_compile() {
    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=/opt/kde${V} --host=${CHOST} \
		--with-qt-dir=$QTBASE
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc README
  docinto html
  dodoc *.html
}
