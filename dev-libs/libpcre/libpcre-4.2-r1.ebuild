# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpcre/libpcre-4.2-r1.ebuild,v 1.10 2004/01/13 16:55:19 agriffis Exp $

inherit libtool

S=${WORKDIR}/pcre-${PV}
DESCRIPTION="Perl-compatible regular expression library"
SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PV}.tar.bz2"
HOMEPAGE="http://www.pcre.org/"

SLOT="3"
LICENSE="as-is"
KEYWORDS="x86 ~ppc sparc alpha hppa amd64 ia64 mips"

DEPEND="virtual/glibc"

src_compile() {
	if [ "${ARCH}" = "amd64" ]
	then
		append-flags -fPIC
	fi
	elibtoolize
	econf --enable-utf8 || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING INSTALL LICENCE NON-UNIX-USE
	dodoc doc/*.txt
	dodoc doc/Tech.Notes
	dohtml -r doc
}
