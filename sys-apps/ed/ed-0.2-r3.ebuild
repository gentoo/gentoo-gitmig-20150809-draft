# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ed/ed-0.2-r3.ebuild,v 1.2 2001/08/26 23:42:15 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Your basic line editor"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/ed/${P}.tar.gz ftp://ftp.gnu.org/pub/gnu/ed/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/ed/"
DEPEND="virtual/glibc sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {  
	./configure --prefix=/ --host=${CHOST} || die
	emake || die
}

src_install() {                               
	make prefix=${D}/ mandir=${D}/usr/share/man/man1 infodir=${D}/usr/share/info install || die
	if [ -z "`use bootcd`" ]
	then
		dodoc COPYING ChangeLog NEWS POSIX README THANKS TODO
	else
		rm -rf ${D}/usr/share
	fi
}
