# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-2.2.ebuild,v 1.4 2001/08/22 11:57:19 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Addons"
SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH
	 http://www.research.att.com/~leonb/objprelink/kde-admin-acinclude.patch"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdemultimedia-${PV}
	>=media-libs/libsdl-1.2
  	objprelink? ( dev-util/objprelink )"

src_unpack() {

	cd ${WORKDIR}
	unpack ${P}.tar.bz2
	cd ${S}
	use objprelink && patch -p0 < ${DISTDIR}/kde-admin-acinclude.patch

}

src_compile() {

    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="$myconf --enable-mt"
    fi
    if [ "`use mitshm`" ]
    then
      myconf="$myconf --enable-mitshm"
    fi
	if [ "`use objprelink`" ] ; then
	  myconf="$myconf --enable-objprelink"
	fi
    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=$KDEDIR --host=${CHOST} \
		--with-qt-dir=$QTBASE \
		--with-xinerama $myconf
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS COPYING README
}



