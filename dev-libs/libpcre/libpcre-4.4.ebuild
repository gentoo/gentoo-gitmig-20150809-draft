# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpcre/libpcre-4.4.ebuild,v 1.7 2004/04/06 03:02:04 vapier Exp $

inherit libtool flag-o-matic

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PV}.tar.bz2"

LICENSE="as-is"
SLOT="3"
KEYWORDS="x86 ~ppc sparc ~alpha hppa ~amd64 ~ia64 ppc64 s390"

DEPEND="virtual/glibc"

S=${WORKDIR}/pcre-${PV}

src_compile() {
	if [ "${ARCH}" = "amd64" -o "${ARCH}" = "hppa" ]
	then
		append-flags -fPIC
	fi
	elibtoolize
	econf --enable-utf8 || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL LICENCE NON-UNIX-USE
	dodoc doc/*.txt
	dodoc doc/Tech.Notes
	dohtml -r doc
}
