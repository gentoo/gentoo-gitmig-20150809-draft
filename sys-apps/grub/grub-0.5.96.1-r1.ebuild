# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grub/grub-0.5.96.1-r1.ebuild,v 1.1 2000/11/14 04:25:31 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU GRUB boot loader"
SRC_URI="ftp://alpha.gnu.org/gnu/grub/${A}"
HOMEPAGE="http://www.gnu.org/software/grub"

src_compile() {                           
	try ./configure --prefix=/usr --host=${CHOST}
	try make
}

src_install() {                               
	try make prefix=${D}/usr install
	cd ${S}
	dodir /boot/boot/grub
	cd ${D}/usr/share/grub/i386-pc
	cp stage1 stage2 *stage1_5 ${D}/boot/boot/grub
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README THANKS TODO
}



