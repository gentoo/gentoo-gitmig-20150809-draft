# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/modutils/modutils-2.4.2.ebuild,v 1.1 2001/02/07 15:51:27 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Standard kernel module utilities"
SRC_URI="http://www.kernel.org/pub/linux/utils/kernel/modutils/v2.4/${A}"

DEPEND="virtual/glibc"

src_compile() {

	try ./configure --prefix=/ --mandir=/usr/share/man --host=${CHOST} --disable-strip
	try make ${MAKEOPTS}
}

src_install() {

	try make prefix=${D} mandir=${D}/usr/share/man install
	dodoc COPYING CREDITS ChangeLog NEWS README TODO
}




