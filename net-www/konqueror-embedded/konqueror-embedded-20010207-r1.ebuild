# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/konqueror-embedded/konqueror-embedded-20010207-r1.ebuild,v 1.11 2003/09/06 01:54:08 msterret Exp $

A=${PN}-snapshot.tar.gz
S=${WORKDIR}/${PN}-snapshot
DESCRIPTION=""
SRC_URI="http://devel-home.kde.org/~hausmann/${A}"
HOMEPAGE="http://www.konqueror.org/embedded.html"
DESCRIPTION="The Konqueror/Embedded project attempts to build up a special version of the web browsing component of the KDE browser Konqueror (in particular its html rendering engine khtml and its io subsystem)"
SLOT="0"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"

src_compile() {
	local myconf
	if [ "`use qt-embedded`" ]
	then
		export QTDIR=/opt/qt-embedded
		export PATH=$QTDIR/bin:$PATH
		export LDFLAGS="-L/usr/lib -lmng -ljpeg"
		myconf="--with-qt-dir=$QTDIR --enable-qt-embedded --enable-static --disable-shared --prefix=/usr/embedded"
	else
		myconf="--prefix=/usr"
	fi
	try ./configure ${myconf} --host=${CHOST} \
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

