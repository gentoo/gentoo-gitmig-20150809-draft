# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-www/konqueror-embedded/konqueror-embedded-20010207-r1.ebuild,v 1.1 2001/10/06 15:30:16 danarmak Exp $

A=${PN}-snapshot.tar.gz
S=${WORKDIR}/${PN}-snapshot
DESCRIPTION=""
SRC_URI="http://devel-home.kde.org/~hausmann/${A}"
HOMEPAGE="http://www.kde.org"

src_compile() {

    local myconf
    if [ "`use qt-embedded`" ]
    then
      export QTDIR=/opt/qt-embedded
      export PATH=$QTDIR/bin:$PATH
      export LDFLAGS="-L/usr/lib -lmng -ljpeg"
      myconf="--enable-qt-embedded --enable-static --disable-shared --prefix=/usr/embedded"
    else
      #export QTDIR=/usr/X11R6/lib/qt
      myconf="--prefix=/usr"
    fi
    try ./configure ${myconf} --host=${CHOST} \
	--with-qt-dir=$QTDIR \
	--with-ssl-dir=/usr
    try make

}

src_install () {

    try make DESTDIR=${D} install
    if [ "`use qt-embedded`" ]
    then
      dodir /usr/embedded/bin
      mv ${D}/usr/embedded/konq* ${D}/usr/embedded/bin
    else
      dodir /usr/bin
      # i don't know what an embedded konq loks like, bt it had better not
      # conflict with the main konqueror of kde! - danarmak
      mv ${D}/usr/konq* ${D}/usr/bin
    fi

}

