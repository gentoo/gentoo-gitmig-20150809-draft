# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grub/grub-0.5.96.1-r1.ebuild,v 1.2 2000/11/30 23:14:33 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU GRUB boot loader"
SRC_URI="ftp://alpha.gnu.org/gnu/grub/${A}"
HOMEPAGE="http://www.gnu.org/software/grub"
DEPEND=">=sys-libs/gpm-1.19.3"

src_compile() {                           
	try ./configure --prefix=/usr --host=${CHOST}
	try make ${MAKEOPTS}
}

src_install() {                               
	try make prefix=${D}/usr install
	cd ${S}
	dodir /boot/boot/grub
	cd ${D}/usr/share/grub/i386-pc
	cp stage1 stage2 *stage1_5 ${D}/boot/boot/grub
	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO
}



