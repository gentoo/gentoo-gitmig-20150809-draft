# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-2.1_beta1.ebuild,v 1.1 2000/12/21 19:16:37 achim Exp $

V=2.1beta1
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE ${V} - Multimedia"
SRC_PATH="kde/unstable/distribution/${V}/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org"

DEPEND=">=kde-base/kdelibs-${PV}
	>=media-libs/alsa-lib-0.5.9"

RDEPEND=$DEPEND

src_unpack () {
  unpack ${A}
}
src_compile() {
    QTBASE=/usr/X11R6/lib/qt
    try ./configure --prefix=/opt/kde2 --host=${CHOST} \
		--with-qt-dir=$QTBASE \
		--with-alsa --enable-audio=alsa,nas
    cp Makefile Makefile.orig
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS ChangeLog COPYING README*
}







