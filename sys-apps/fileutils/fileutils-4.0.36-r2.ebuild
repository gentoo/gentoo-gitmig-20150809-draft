# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fileutils/fileutils-4.0.36-r2.ebuild,v 1.1 2001/02/07 15:51:27 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls, etc)"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${A}"
HOMEPAGE="http://www.gnu.org/software/fileutils/fileutils.html"

DEPEND="virtual/glibc
        >=sys-devel/gettext-0.10.35-r2"

RDEPEND="virtual/glibc"

src_compile() {

	try ./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --bindir=/bin
	try make ${MAKEOPTS}
}

src_install() {

	make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info bindir=${D}/bin install

	cd ${D}
        dodir /usr/bin
        rm -rf usr/lib
        cd usr/bin
        ln -s ../../bin/* .


        cd ${S}
       	dodoc COPYING NEWS README*  THANKS TODO ChangeLog ChangeLog-1997 AUTHORS

}

