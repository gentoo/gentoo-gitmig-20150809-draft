# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pwdb/pwdb-0.61-r3.ebuild,v 1.2 2001/08/22 21:18:13 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Password database"
SRC_URI="ftp://gentoolinux.sourceforge.net/pub/gentoolinux/current/distfiles/${P}.tar.gz"
DEPEND="virtual/glibc"
RDEPEND="virtual/glibc >=sys-libs/pam-0.75-r1"

src_unpack () {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_compile() {
	cp Makefile Makefile.orig
	sed -e "s/^DIRS = .*/DIRS = libpwdb/" -e "s:EXTRAS += :EXTRAS += ${CFLAGS} :" Makefile.orig > Makefile
	make ${MAKEOPTS} || die
}

src_install() {
	into /usr
	dodir /usr/include/pwdb
	dodir /lib
	make INCLUDED=${D}/usr/include/pwdb LIBDIR=${D}/lib LDCONFIG="echo" install || die
	preplib /
	dodir /usr/lib
	mv ${D}/lib/*.a ${D}/usr/lib
	dodoc CHANGES Copyright CREDITS README
	docinto html
	dodoc doc/html/*
	docinto txt
	dodoc doc/*.txt
	insinto /etc
	doins conf/pwdb.conf
	cd ${FILESDIR}
	insinto /etc/pam.d
	doins passwd
}
