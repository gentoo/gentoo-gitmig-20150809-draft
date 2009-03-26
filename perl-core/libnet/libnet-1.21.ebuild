# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/libnet/libnet-1.21.ebuild,v 1.13 2009/03/26 12:29:40 armin76 Exp $

inherit perl-module

DESCRIPTION="A URI Perl Module"
HOMEPAGE="http://search.cpan.org/~gbarr/"
SRC_URI="mirror://cpan/authors/id/G/GB/GBARR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="sasl"

SRC_TEST="do"

DEPEND="dev-lang/perl
		sasl? ( dev-perl/Authen-SASL )"

src_unpack() {
	perl-module_src_unpack
	cp "${FILESDIR}"/libnet.cfg "${S}"
}
