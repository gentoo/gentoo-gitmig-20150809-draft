# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-2.1.1.ebuild,v 1.3 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Network"
SRC_PATH="kde/stable/${PV}/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org"

DEPEND=">=kde-base/kdelibs-${PV}
	>=kde-base/kdesupport-2.1"

RDEPEND=$DEPEND

src_compile() {
    QTBASE=/usr/X11R6/lib/qt
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
    if [ "`use mitshm`" ]
    then
      myconf="$myconf --enable-mitshm"
    fi
    try ./configure --prefix=/opt/kde2.1 --host=${CHOST} \
                --with-qt-dir=$QTBASE $myconf
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS COPYING README
}
