# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtasn1/libtasn1-0.2.18.ebuild,v 1.12 2006/04/23 13:34:40 flameeyes Exp $

inherit libtool

DESCRIPTION="provides ASN.1 structures parsing capabilities for use with GNUTLS"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/libtasn1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc"

DEPEND=">=dev-lang/perl-5.6
	sys-devel/bison"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	elibtoolize
}

src_install() {
	make DESTDIR="${D}" install || die "installed failed"

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	use doc && dodoc doc/asn1.ps
}
