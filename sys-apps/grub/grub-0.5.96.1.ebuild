# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grub/grub-0.5.96.1.ebuild,v 1.1 2000/11/13 01:06:54 drobbins Exp $

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
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README THANKS TODO
}



