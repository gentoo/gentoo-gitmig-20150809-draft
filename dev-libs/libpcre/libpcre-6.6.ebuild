# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpcre/libpcre-6.6.ebuild,v 1.12 2006/10/17 02:54:31 tsunam Exp $

inherit libtool flag-o-matic eutils

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PV}.tar.bz2"

LICENSE="BSD"
SLOT="3"
KEYWORDS="~alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc"

DEPEND="dev-util/pkgconfig"
RDEPEND=""
S=${WORKDIR}/pcre-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/pcre-6.3-uclibc-tuple.patch
	epatch "${FILESDIR}"/pcre-6.4-link.patch

	# Added for bug #130668 -- fix parallel builds
	epatch "${FILESDIR}"/pcre-6.6-parallel-build.patch

	# TODO: Fix this.  Use -fPIC just for the shared objects.
	# position-independent code must used for all shared objects.
	ewarn "TODO: Fix this bad -fPIC handling"
	append-flags -fPIC

	elibtoolize
}

src_compile() {
	# How about the following flags?
	# --enable-unicode-properties  enable Unicode properties support
	# --disable-stack-for-recursion  disable use of stack recursion when matching
	econf --enable-utf8 || die
	emake all libpcrecpp.la || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS INSTALL NON-UNIX-USE
	dodoc doc/*.txt doc/Tech.Notes
	use doc && dohtml doc/html/*
}
