# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpcre/libpcre-3.9.ebuild,v 1.13 2004/06/24 23:21:47 agriffis Exp $

S=${WORKDIR}/pcre-${PV}
DESCRIPTION="Perl-compitable regular expression library"
SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PV}.tar.bz2"
HOMEPAGE="http://www.pcre.org/"

SLOT="3"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING INSTALL LICENCE NON-UNIX-USE
	dodoc doc/*.txt
	dodoc doc/Tech.Notes
	dohtml =r doc
}
