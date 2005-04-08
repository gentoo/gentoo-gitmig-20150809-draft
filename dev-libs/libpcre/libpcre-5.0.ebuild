# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpcre/libpcre-5.0.ebuild,v 1.9 2005/04/08 16:09:25 corsair Exp $

inherit libtool flag-o-matic eutils gnuconfig

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PV}.tar.bz2"

LICENSE="BSD"
SLOT="3"
KEYWORDS="alpha amd64 arm hppa ia64 mips ~ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/pcre-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/pcre-5.0-uclibc-tuple.patch
	epatch "${FILESDIR}"/pcre-4.2-link.patch
	use ppc-macos && epatch "${FILESDIR}"/pcre-5.0-macos.patch
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

	if use ppc-macos; then
		cd ${D}/usr/lib
		for i in libpcre{,.0.0.1,.0} libpcreposix{,.0.0.0,.0}; do
			mv $i $i.dylib
		done
		ln -sf libpcre.0.0.1.dylib libpcre.dylib
		ln -sf libpcre.0.0.1.dylib libpcre.0.dylib
		ln -sf libpcreposix.0.0.0.dylib libpcreposix.dylib
		ln -sf libpcreposix.0.0.0.dylib libpcreposix.0.dylib
	fi

	dodoc AUTHORS INSTALL NON-UNIX-USE
	dodoc doc/*.txt
	dodoc doc/Tech.Notes
	dohtml -r doc
}
