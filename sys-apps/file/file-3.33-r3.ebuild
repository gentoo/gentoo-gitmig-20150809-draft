# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-3.33-r3.ebuild,v 1.3 2001/10/06 16:51:30 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Program to identify a file's format by scanning binary data for patterns"
SRC_URI="ftp://ftp.astron.com/pub/file/${P}.tar.bz"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr --mandir=/usr/share/man --datadir=/usr/share/misc --host=${CHOST} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
if [ -z "`use build`" ]
	then
		dodoc LEGAL.NOTICE MAINT README
	else
		rm -rf ${D}/usr/share/man
	fi
}



