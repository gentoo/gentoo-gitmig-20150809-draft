# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias  <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-2.2_beta1.ebuild,v 1.4 2001/09/29 21:03:26 danarmak Exp $


V=2.2beta1
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}-${V}
DESCRIPTION="KDE ${V} - PIM"
SRC_PATH="kde/unstable/${V}/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http:/www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV} >=dev-libs/pilot-link-0.9.0 sys-devel/perl"
RDEPEND=">=kde-base/kdelibs-${PV} >=dev-libs/pilot-link-0.9.0"

src_compile() {
    QTBASE=/usr/X11R6/lib/qt
     local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
    try ./configure --prefix=${KDEDIR} --host=${CHOST} \
		--with-qt-dir=$QTBASE --with-xinerama $myconf
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc README
  docinto html
  dodoc *.html
}
