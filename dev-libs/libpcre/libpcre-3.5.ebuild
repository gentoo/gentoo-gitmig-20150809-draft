# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpcre/libpcre-3.5.ebuild,v 1.1 2001/11/22 18:57:24 verwilst Exp $

S=${WORKDIR}/pcre-${PV}
DESCRIPTION="Perl compatible regular expressions"
SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PV}.tar.gz"
DEPEND="virtual/glibc"

src_compile() {                           
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man
	assert

	make || die
}

src_install() {                               
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog LICENCE NEWS NON-UNIX-USE README
	dodoc doc/*.txt doc/Tech.Notes
	docinto html
	dodoc doc/*.html
}
