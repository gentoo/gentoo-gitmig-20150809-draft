# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-2.1.1.ebuild,v 1.5 2001/08/31 03:23:39 pm Exp $


A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Graphics"
SRC_PATH="kde/stable/${PV}/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org"

DEPEND=">=kde-base/kdelibs-${PV} sys-devel/perl
	tex? ( >=app-text/tetex-1.0.7 )
        gphoto2? ( >=gnome-apps/gphoto-2.0_beta1 >=media-libs/libgpio-20010607 )"

RDEPEND=">=kde-base/kdelibs-${PV} gphoto2? ( >=gnome-apps/gphoto-2.0_beta1 >=media-libs/libgpio-20010607 )"

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
    if [ "`use gphoto2`" ] ; then
      myconf="$myconf --with-gphoto2-includes=/usr/include/gphoto2 --with-gphoto2-libraries=/usr/lib/gphoto2"
    else
      myconf="$myconf --without-kamera"
    fi
    try ./configure --prefix=/opt/kde2.1 --host=${CHOST} \
		--with-qt-dir=$QTBASE $myconf
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS COPYING README ChangeLog
}




