# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

V=2.0
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}-${V}
DESCRIPTION="KDE ${V} - Develop"
SRC_PATH="kde/stable/2.2/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${V} sys-devel/flex sys-devel/perl"
RDEPEND=">=kde-base/kdelibs-${V}"

src_compile() {
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
    if [ "`use mitshm`" ]
    then
      myconf="$myconf --enable-mitshm"
    fi
    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=$KDEDIR --host=${CHOST} \
		--with-qt-dir=$QTBASE $myconf
    try make

}

src_install() {

  try make install DESTDIR=${D}
  dodoc AUTHORS BUGS COPYING ChangeLog FAQ README* TODO
  docinto html
  dodoc *.html

}



