# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/modutils/modutils-2.4.8.ebuild,v 1.1 2001/08/31 06:01:21 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard kernel module utilities"
SRC_URI="http://www.kernel.org/pub/linux/utils/kernel/modutils/v2.4/${P}.tar.bz2"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/ --mandir=/usr/share/man --host=${CHOST} --disable-strip || die
	emake || die
}

src_install() {
	make prefix=${D} mandir=${D}/usr/share/man install || die
	dodoc COPYING CREDITS ChangeLog NEWS README TODO
}




