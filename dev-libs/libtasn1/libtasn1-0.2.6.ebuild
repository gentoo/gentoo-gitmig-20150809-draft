# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtasn1/libtasn1-0.2.6.ebuild,v 1.8 2004/11/21 05:33:12 kingtaco Exp $

DESCRIPTION="This is the library which provides ASN.1 structures parsing capabilities for use with GNUTLS"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/libtasn1/${P}.tar.gz"

IUSE="doc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 s390 ~sparc ~ppc ~alpha ~amd64"

DEPEND=">=dev-lang/perl-5.6
	dev-util/yacc"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "installed failed"

	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS TODO
	use doc && dodoc doc/asn1.ps
}
