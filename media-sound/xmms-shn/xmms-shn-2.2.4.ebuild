# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-shn/xmms-shn-2.2.4.ebuild,v 1.1 2001/10/23 03:30:10 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="This input plugin allows xmms to play .shn compressed (lossless) files"
SRC_URI="http://shnutils.etree.org/xmms-shn/source/${P}.tar.bz2"
HOMEPAGE="http://shnutils.etree.org/xmms-shn"
DEPEND="virtual/glibc >=media-sound/xmms-1.2.5-r1"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	make || die
}

src_install() {
	make DESTDIR=${D} libdir=/usr/lib/xmms/Input install || die
	dodoc AUTHORS COPYING NEWS README
}

