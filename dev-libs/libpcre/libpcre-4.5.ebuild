# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpcre/libpcre-4.5.ebuild,v 1.9 2004/11/13 05:50:26 vapier Exp $

inherit libtool flag-o-matic eutils gnuconfig

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PV}.tar.bz2"

LICENSE="as-is"
SLOT="3"
KEYWORDS="x86 ~ppc sparc alpha arm hppa amd64 ia64 ~ppc64 s390 mips ~ppc-macos sh"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/pcre-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/pcre-4.4-uclibc-tuple.patch
	epatch ${FILESDIR}/pcre-4.2-link.patch
	use ppc-macos && epatch ${FILESDIR}/pcre-4.2-macos.patch
	# position-independent code must used for all shared objects.
	append-flags -fPIC
	elibtoolize
	gnuconfig_update
}

src_compile() {
	econf --enable-utf8 || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL NON-UNIX-USE
	dodoc doc/*.txt
	dodoc doc/Tech.Notes
	dohtml -r doc
}
