# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-aalsa/xmms-aalsa-0.5.4.ebuild,v 1.4 2001/01/16 15:26:10 achim Exp $

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
	local myconf
	if [ -n "`use gnome`" ]
	then
	  myconf="--prefix=/opt/gnome"
	else
	  myconf="--prefix=/usr/X11R6"
	fi
	try ./configure ${myconf} --host=${CHOST}
	try make
}

src_install() {    
                           
	try make DESTDIR=${D} install
	dodoc AUTHORS COPYING NEWS README
}

