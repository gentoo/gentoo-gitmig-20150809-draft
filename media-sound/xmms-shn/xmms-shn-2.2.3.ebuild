# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-shn/xmms-shn-2.2.3.ebuild,v 1.1 2001/02/03 04:15:51 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="This input plugin allows xmms to play .shn compressed (lossless) files"
SRC_URI="http://shnutils.freeshell.org/xmms-shn/xmms-shn-2.2.3.tar.bz2"
HOMEPAGE="http://shnutils.freeshell.org/xmms-shn"
DEPEND=">=sys-libs/glibc-2.1.3 >=media-sound/xmms-1.2.3"

src_unpack() {
	unpack ${A}
}

src_compile() {     
	local myconf
	if [ "`use gnome`" ]
	then
	  myconf="--prefix=/opt/gnome"
	else
	  myconf="--prefix=/usr/X11R6"
	fi
	try ./configure $myconf --host=${CHOST}
	try make
}

src_install() {                               
	try make DESTDIR=${D} install
	dodoc AUTHORS COPYING NEWS README
}

