# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# /home/cvsroot/gentoo-x86/kde-base/kdenetwork/kinkatta-0.91.ebuild v 1 2001/08/29

S=${WORKDIR}/${P}
DESCRIPTION="KDE Aim Clone"
SRC_PATH="kinkatta/${P}.tar.gz"
SRC_URI="http://ftp1.sourceforge.net/$SRC_PATH
	 http://www.research.att.com/~leonb/objprelink/kde-admin-acinclude.patch"

HOMEPAGE="http://www.kde.org"

DEPEND=">=kde-base/kdebase-${PV}
 	objprelink? ( dev-util/objprelink )"

RDEPEND=$DEPEND

src_unpack() {

	cd ${WORKDIR}
	unpack ${P}.tar.gz
	cd ${S}
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
	if [ "`use objprelink`" ] ; then
	  myconf="$myconf --enable-objprelink"
	fi
    try ./configure --prefix=${KDEDIR} --host=${CHOST} \
                --with-qt-dir=$QTBASE --with-xinerama $myconf
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS COPYING README
}
