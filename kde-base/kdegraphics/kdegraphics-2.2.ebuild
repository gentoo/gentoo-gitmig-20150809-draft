# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-2.2.ebuild,v 1.6 2001/09/25 03:41:12 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Graphics"
SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH
	 http://www.research.att.com/~leonb/objprelink/kde-admin-acinclude.patch"

HOMEPAGE="http://www.kde.org"

DEPEND=">=kde-base/kdelibs-${PV} sys-devel/perl
	tex? ( >=app-text/tetex-1.0.7 )
        gphoto2? ( >=media-gfx/gphoto-2.0_beta1 >=media-libs/libgpio-20010607 )
 	objprelink? ( dev-util/objprelink )"

RDEPEND=">=kde-base/kdelibs-${PV} gphoto2? ( >=media-gfx/gphoto-2.0_beta1 >=media-libs/libgpio-20010607 )"

src_unpack() {

	cd ${WORKDIR}
	unpack ${P}.tar.bz2
	cd ${S}
	 patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
	use objprelink && patch -p0 < ${DISTDIR}/kde-admin-acinclude.patch

}

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
	if [ "`use objprelink`" ] ; then
	  myconf="$myconf --enable-objprelink"
	fi
    try ./configure --prefix=${KDEDIR} --host=${CHOST} \
		--with-qt-dir=$QTBASE $myconf --with-xinerama
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS COPYING README ChangeLog
}




