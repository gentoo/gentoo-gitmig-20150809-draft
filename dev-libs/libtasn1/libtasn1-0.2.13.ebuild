# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtasn1/libtasn1-0.2.13.ebuild,v 1.5 2005/02/21 18:09:25 agriffis Exp $

DESCRIPTION="This is the library which provides ASN.1 structures parsing capabilities for use with GNUTLS"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/libtasn1/${P}.tar.gz"

IUSE="doc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~s390 ~sparc ~ppc ~alpha ~amd64 ~mips ~ppc64 ~hppa ~ia64"

DEPEND=">=dev-lang/perl-5.6
	sys-devel/bison"

src_install() {
	emake DESTDIR=${D} install || die "installed failed"

	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS TODO
	use doc && dodoc doc/asn1.ps
}
