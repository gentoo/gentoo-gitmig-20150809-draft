# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.4.1-r2.ebuild,v 1.1 2002/03/19 16:05:25 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A shared library tool for developers"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	patch -p0 <${FILESDIR}/libtool-${PV}-relink.patch || die
}

src_compile() {
	./configure --host=${CHOST} \
			--prefix=/usr \
			--infodir=/usr/share/info || die

	emake || die
}

src_install() { 
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog* NEWS \
	      README THANKS TODO doc/PLATFORMS	

	cd ${D}/usr/share/libtool
	patch -p0 < ${FILESDIR}/1.4/${PN}-1.4.ltmain.sh-hack.diff || die
}




