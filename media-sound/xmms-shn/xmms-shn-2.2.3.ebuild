# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-shn/xmms-shn-2.2.3.ebuild,v 1.4 2001/06/06 16:55:51 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="This input plugin allows xmms to play .shn compressed (lossless) files"
SRC_URI="http://shnutils.freeshell.org/xmms-shn/source/xmms-shn-2.2.3.tar.bz2"
HOMEPAGE="http://shnutils.freeshell.org/xmms-shn"
DEPEND="virtual/glibc >=media-sound/xmms-1.2.3"

src_compile() {
	if [ "`use gnome`" ]
	then
	  echo /opt/gnome > ${S}/mydest
	else
	  echo /usr/X11R6 > ${S}/mydest
	fi
	try ./configure --prefix=`cat ${S}/mydest` --host=${CHOST}
	try make
}

src_install() {
	try make DESTDIR=${D} libdir=`cat ${S}/mydest`/lib/xmms/Input install
	dodoc AUTHORS COPYING NEWS README
}

