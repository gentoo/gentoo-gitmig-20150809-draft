# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pwdb/pwdb-0.61-r3.ebuild,v 1.20 2003/06/22 05:10:31 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Password database"
SRC_URI="ftp://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="http://www.firstlinux.com/cgi-bin/package/content.cgi?ID=6886"
DEPEND="virtual/glibc"
LICENSE="PWDB"
KEYWORDS="x86 ppc sparc alpha"
SLOT="0"

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
	dohtml -r doc
	docinto txt
	dodoc doc/*.txt
	insinto /etc
	doins conf/pwdb.conf
#	insinto /etc/pam.d
#	doins ${FILESDIR}/passwd
}
