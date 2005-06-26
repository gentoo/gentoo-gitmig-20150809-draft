# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpcre/libpcre-5.0.ebuild,v 1.13 2005/06/26 06:16:27 j4rg0n Exp $

inherit libtool flag-o-matic eutils

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PV}.tar.bz2"

LICENSE="BSD"
SLOT="3"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/pcre-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/pcre-5.0-uclibc-tuple.patch
	use ppc-macos || epatch "${FILESDIR}"/pcre-4.2-link.patch

	# position-independent code must used for all shared objects.
	append-flags -fPIC
	use ppc-macos || elibtoolize
	epunt_cxx
}

src_compile() {
	econf --enable-utf8 || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS INSTALL NON-UNIX-USE
	dodoc doc/*.txt doc/Tech.Notes
	dohtml -r doc/*
}
