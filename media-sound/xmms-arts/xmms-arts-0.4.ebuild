# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-arts/xmms-arts-0.4.ebuild,v 1.1 2001/01/16 05:22:23 drobbins Exp $

S=${WORKDIR}/xmms-arts-0.4
DESCRIPTION="This output plugin allows xmms to work with arts, KDE's sound system"
SRC_URI="http://home.earthlink.net/~bheath/xmms-arts/xmmsarts-0.4.tar.gz
DEPEND=">=sys-libs/glibc-2.1.3 >=media-sound/xmms-1.2.3 >=kde-base/kde-2.0.1"

src_unpack() {
	unpack ${A}
	cp configure.in configure.in.orig
	sed -e 's:^CFLAGS="$CFLAGS $GLIB_CFLAGS":CFLAGS="$CFLAGS $GLIB_CFLAGS -I/usr/X11R6/include":' configure.in.orig > configure.in
	autoconf
}

src_compile() {                           
	try ./configure prefix=/usr/X11R6
	try make
}

src_install() {                               
	try make prefix=${D}/usr/X11R6 install
	dodoc AUTHORS COPYING NEWS README
}

