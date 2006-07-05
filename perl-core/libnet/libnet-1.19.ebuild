# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/libnet/libnet-1.19.ebuild,v 1.3 2006/07/05 20:04:53 ian Exp $

inherit perl-module

DESCRIPTION="A URI Perl Module"
HOMEPAGE="http://search.cpan.org/~gbarr/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GB/GBARR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="sasl"

DEPEND="sasl? ( dev-perl/Authen-SASL )"
RDEPEND="${DEPEND}"

src_compile() {
	cp ${O}/files/libnet.cfg .
	perl-module_src_compile
}