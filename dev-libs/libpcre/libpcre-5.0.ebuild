# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpcre/libpcre-5.0.ebuild,v 1.5 2005/02/06 23:43:16 kloeri Exp $

IUSE=""

inherit libtool flag-o-matic eutils gnuconfig

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PV}.tar.bz2"

LICENSE="BSD"
SLOT="3"
KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sh sparc x86"

DEPEND="virtual/libc"

S=${WORKDIR}/pcre-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/pcre-5.0-uclibc-tuple.patch
	epatch ${FILESDIR}/pcre-4.2-link.patch
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
	make DESTDIR="${D}" install || die

	dodoc AUTHORS INSTALL NON-UNIX-USE
	dodoc doc/*.txt
	dodoc doc/Tech.Notes
	dohtml -r doc
}
