# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-2.2_beta1.ebuild,v 1.3 2001/08/31 03:23:39 pm Exp $


V=2.2beta1
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}-${V}
DESCRIPTION="KDE ${V} - Utilities"
SRC_PATH="kde/unstable/${V}/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV}"
RDEPEND="$DEPEND"

src_compile() {
    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=${KDEDIR} --host=${CHOST} \
                --with-qt-dir=$QTBASE --with-xinerama
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS COPYING README
}
