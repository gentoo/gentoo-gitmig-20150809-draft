# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-2.1.1-r1.ebuild,v 1.4 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Administration"
SRC_PATH="kde/stable/${PV}/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"
HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV}
	>=app-arch/rpm-3.0.5
	pam? ( >=sys-libs/pam-0.72 )"

RDEPEND=$DEPEND

src_compile() {

    local myconf
    if [ "`use pam`" ]
    then
      myconf="--with-pam"
    else
      myconf="--without-pam"
    fi
    if [ "`use qtmt`" ]
    then
      myconf="$myconf --enable-mt"
    fi
    if [ "`use mitshm`" ]
    then
      myconf="$myconf --enable-mitshm"
    fi
    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=$KDEDIR --host=${CHOST} \
		--with-qt-dir=$QTBASE \
		--with-rpm $myconf
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS COPYING README
}



