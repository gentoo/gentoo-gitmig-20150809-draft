# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bzip2/bzip2-1.0.1-r4.ebuild,v 1.2 2001/10/06 16:44:02 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A high-quality data compressor used extensively by Gentoo Linux"
SRC_URI="ftp://sourceware.cygnus.com/pub/bzip2/v100/${P}.tar.gz ftp://ftp.freesoftware.com/pub/sourceware/bzip2/v100/${P}.tar.gz"
HOMEPAGE="http://sourceware.cygnus.com/bzip2/"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/bzip2-1.0.1-Makefile-gentoo.diff
	cp ${FILESDIR}/Makefile.dietlibc .
}

src_compile() {
	if [ -z "`use build`" ]
	then
		emake -f Makefile-libbz2_so all || die
	fi
	emake all || die
}
src_install() {
	if [ -z "`use build`" ]
	then
		make DESTDIR=${D} install || die
		mv ${D}/usr/bin ${D}
		make DESTDIR=${D} -f Makefile-libbz2_so install || die
		dodoc README LICENSE CHANGES Y2K_INFO
		docinto txt
		dodoc bzip2.txt
		docinto ps
		dodoc manual.ps
		docinto html
		dodoc manual_*.html
	else
		into /
		dobin bzip2
		cd ${D}/bin
		ln -s bzip2 bunzip2        
	fi
}


