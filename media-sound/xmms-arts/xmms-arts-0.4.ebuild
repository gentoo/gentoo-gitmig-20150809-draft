# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-arts/xmms-arts-0.4.ebuild,v 1.6 2001/08/11 03:50:11 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="This output plugin allows xmms to work with arts, KDE's sound system"
SRC_URI="http://home.earthlink.net/~bheath/xmms-arts/xmmsarts-0.4.tar.gz"
HOMEPAGE="http://home.earthlink.net/~bheath/xmms-arts/"

DEPEND="virtual/glibc >=media-sound/xmms-1.2.3 >=kde-base/kdelibs-2.1.1 sys-devel/autoconf"
RDEPEND="virtual/glibc >=media-sound/xmms-1.2.3 >=kde-base/kdelibs-2.1.1"
src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile.am Makefile.orig
	sed -e "s:artsc-config:${KDEDIR}/bin/artsc-config:" Makefile.orig > Makefile.am
	autoconf
}

src_compile() {     
	local myconf
	if [ "`use gnome`" ]
	then
	  myconf="--prefix=/opt/gnome"
	else
	  myconf="--prefix=/usr/X11R6"
	fi
	try CFLAGS="$CFLAGS -I/usr/X11R6/include -I/opt/gnome/include" ./configure $myconf --host=${CHOST}
	try make
}

src_install() {                               
	try make DESTDIR=${D} install
	dodoc AUTHORS COPYING NEWS README
}

