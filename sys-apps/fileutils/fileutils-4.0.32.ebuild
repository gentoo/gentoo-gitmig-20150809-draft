# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fileutils/fileutils-4.0.32.ebuild,v 1.3 2000/11/30 23:14:32 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls, etc)"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${A}"
HOMEPAGE="http://www.gnu.org/software/fileutils/fileutils.html"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() { 
	#we are waiting for GNU fileutils 4.0.30 which will become standard in Gentoo 1.0
	#until then, we wait.
	try ./configure --prefix=/usr 
	try make ${MAKEOPTS}
}

src_install() {                               
	dodoc COPYING NEWS README*  THANKS TODO ChangeLog ChangeLog-1997 AUTHORS
	make prefix=${D}/usr install
	cd ${D}
	mv usr/bin .

}

