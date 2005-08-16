# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtasn1/libtasn1-0.2.13.ebuild,v 1.14 2005/08/16 05:10:26 vapier Exp $

DESCRIPTION="provides ASN.1 structures parsing capabilities for use with GNUTLS"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/libtasn1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sparc x86"
IUSE="doc"

DEPEND=">=dev-lang/perl-5.6
	sys-devel/bison"

src_install() {
	make DESTDIR="${D}" install || die "installed failed"

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	use doc && dodoc doc/asn1.ps
}
