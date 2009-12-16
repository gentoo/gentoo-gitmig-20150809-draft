# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/libnet/libnet-1.21.ebuild,v 1.14 2009/12/16 21:52:17 abcd Exp $

inherit perl-module

DESCRIPTION="A URI Perl Module"
HOMEPAGE="http://search.cpan.org/~gbarr/"
SRC_URI="mirror://cpan/authors/id/G/GB/GBARR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x86-solaris"
IUSE="sasl"

SRC_TEST="do"

DEPEND="dev-lang/perl
		sasl? ( dev-perl/Authen-SASL )"

src_unpack() {
	perl-module_src_unpack
	cp "${FILESDIR}"/libnet.cfg "${S}"
}
