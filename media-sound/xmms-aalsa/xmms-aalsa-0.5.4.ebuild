# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-aalsa/xmms-aalsa-0.5.4.ebuild,v 1.2 2001/01/16 06:45:13 drobbins Exp $

S=${WORKDIR}/xmms-aalsa_0.5.4
DESCRIPTION="This output plugin allows xmms to work with arts, KDE's sound system"
SRC_URI="http://www1.tcnet.ne.jp/fmurata/linux/aalsa/xmms-alsa_0.5.4.tar.gz"
DEPEND=">=sys-libs/glibc-2.1.3 >=media-sound/xmms-1.2.3 >=media-libs/alsa-lib-0.5.9"

src_unpack() {
	unpack ${A}
	cp configure configure.orig
	sed -e "s:-O2:${CFLAGS}:g" configure.orig > configure
}

src_compile() {                           
	try ./configure prefix=/usr/X11R6
	try make
}

src_install() {                               
	try make prefix=${D}/usr/X11R6 install
	dodoc AUTHORS COPYING NEWS README
}

