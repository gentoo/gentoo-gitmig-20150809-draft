# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-aalsa/xmms-aalsa-0.5.4-r3.ebuild,v 1.1 2001/10/06 17:22:51 azarah Exp $

S=${WORKDIR}/xmms-aalsa_0.5.4
DESCRIPTION="This output plugin allows xmms to work with arts, KDE's sound system"
SRC_URI="http://www1.tcnet.ne.jp/fmurata/linux/aalsa/xmms-aalsa_0.5.4.tar.gz"

DEPEND="virtual/glibc >=media-sound/xmms-1.2.5-r1 >=media-libs/alsa-lib-0.5.9"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp -a configure configure.orig
	sed -e "s:-O2:${CFLAGS}:g" configure.orig > configure
}

src_compile() {
	try ./configure --prefix=/usr --host=${CHOST}
	try make
}

src_install() {
	try make DESTDIR=${D} libdir=/usr/lib/xmms/Output install
	dodoc AUTHORS COPYING NEWS README
}

