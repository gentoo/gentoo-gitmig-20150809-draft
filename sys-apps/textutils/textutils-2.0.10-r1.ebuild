# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/textutils/textutils-2.0.10-r1.ebuild,v 1.1 2001/02/07 15:51:28 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU text utilities"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${A}"

DEPEND="virtual/glibc
        >=sys-devel/gettext-0.10.35-r2"

RDEPEND="virtual/glibc"

src_compile() {

	try ./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --host=${CHOST} --build=${CHOST} \
	--without-included-regex
	try make ${MAKEOPTS}
}

src_install() {

	try make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
	dodir /bin
	dosym /usr/bin/cat /bin/cat
	rmdir ${D}/usr/lib

        dodoc AUTHORS COPYING ChangeLog NEWS README* THANKS TODO

}




