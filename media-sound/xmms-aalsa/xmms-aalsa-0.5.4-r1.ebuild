# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-aalsa/xmms-aalsa-0.5.4-r1.ebuild,v 1.1 2001/02/03 03:56:17 drobbins Exp $

S=${WORKDIR}/xmms-aalsa_0.5.4
DESCRIPTION="This output plugin allows xmms to work with arts, KDE's sound system"
SRC_URI="http://www1.tcnet.ne.jp/fmurata/linux/aalsa/xmms-aalsa_0.5.4.tar.gz"
DEPEND=">=sys-libs/glibc-2.1.3 >=media-sound/xmms-1.2.3 >=media-libs/alsa-lib-0.5.9"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp configure configure.orig
	sed -e "s:-O2:${CFLAGS}:g" configure.orig > configure
}

src_compile() {                           
	if [ -n "`use gnome`" ]
	then
	  echo /opt/gnome > ${T}/mydest
	else
	  echo /usr/X11R6 > ${T}/mydest
	fi
	try ./configure --prefix=`cat ${T}/mydest` --host=${CHOST}
	try make
}

src_install() {    
	try make DESTDIR=${D} libdir=`cat ${T}/mydest`/lib/xmms/Output install
	dodoc AUTHORS COPYING NEWS README
}

