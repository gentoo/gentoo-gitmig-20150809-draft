# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

V="1.4"
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}-${V}
DESCRIPTION="KDE ${PV} - SDK"
SRC_PATH="kde/stable/2.1/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"
HOMEPAGE="http://www.kde.org/"

DEPEND=">=dev-util/cvs-${PV}
	>=kde-base/kdelibs-${PV}"

RDEPEND=$DEPEND

src_compile() {

    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=/opt/kde2.1 --host=${CHOST} \
		--with-qt-dir=$QTBASE
    try make

}

src_install() {

  try make install DESTDIR=${D}
  dodoc AUTHORS BUGS COPYING ChangeLog FAQ README* TODO
  docinto html
  dodoc *.html

}



