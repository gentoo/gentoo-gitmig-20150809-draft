# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/tar/tar-1.13.18-r1.ebuild,v 1.2 2001/02/15 18:17:32 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}

DESCRIPTION="Use this to try make tarballs :)"
SRC_URI="ftp://alpha.gnu.org/gnu/tar/"${A}
HOMEPAGE="http://www.gnu.org/software/tar/"

src_compile() {                           
	try ./configure --prefix=/usr --libexecdir=/usr/lib/misc \
                --host=${CHOST} --disable-nls
	try make ${MAKEOPTS} LDFLAGS=-static
}

src_install() {
	cd ${S}
	try make DESTDIR=${D} install
	mv ${D}/usr/bin ${D}
        rm -rf ${D}/usr/info 

}


