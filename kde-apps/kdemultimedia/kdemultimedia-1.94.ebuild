# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kdemultimedia/kdemultimedia-1.94.ebuild,v 1.2 2000/09/21 04:21:02 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE 2 FinalBeta - Multimedia"
SRC_URI="http://download.sourceforge.net/mirrors/kde/unstable/distribution/2.0Beta5/tar/src/"${A}
HOMEPAGE="http://www.kde.org"

src_unpack () {
  unpack ${A}
  cp ${FILESDIR}/alsa_a.cpp ${S}/kmidi/
}
src_compile() {
    try ./configure --prefix=/opt/kde --host=${CHOST} \
		--with-qt-dir=/usr/lib/qt-x11-2.2.0 \
		--with-qt-includes=/usr/lib/qt-x11-2.2.0/include \
		--with-qt-libs=/usr/lib/qt-x11-2.2.0/lib \
		--with-alsa --enable-audio=alsa,oss
    cp Makefile Makefile.orig
#    sed -e "s: kmidi : :" \
#	-e "s: kmidi : :" Makefile.orig > Makefile
    try make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc AUTHORS ChangeLog COPYING README*
}







