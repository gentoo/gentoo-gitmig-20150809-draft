# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpcre/libpcre-7.0.ebuild,v 1.1 2007/01/27 11:53:28 masterdriverz Exp $

inherit libtool eutils

MY_P="pcre-${PV}"

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="3"
KEYWORDS="~x86"
IUSE="doc unicode static"

DEPEND="dev-util/pkgconfig"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/pcre-6.3-uclibc-tuple.patch"
	epatch "${FILESDIR}/pcre-6.4-link.patch"

	# Added for bug #130668 -- fix parallel builds
	epatch "${FILESDIR}/pcre-6.6-parallel-build.patch"

	elibtoolize
}

src_compile() {
	if use unicode; then
		myconf="--enable-utf8 --enable-unicode-properties"
	fi

	econf ${myconf} $(use_enable static) || die "econf failed"
	emake all libpcrecpp.la || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc doc/*.txt doc/Tech.Notes AUTHORS
	use doc && dohtml doc/html/*
}
