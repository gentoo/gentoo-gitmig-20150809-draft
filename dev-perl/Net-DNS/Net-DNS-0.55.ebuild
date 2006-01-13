# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS/Net-DNS-0.55.ebuild,v 1.1 2006/01/13 15:35:26 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl Net::DNS - Perl DNS Resolver Module"
SRC_URI="mirror://cpan/authors/id/O/OL/OLAF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~olaf/${P}/"

SLOT="0"
LICENSE="Artistic"
#KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE="ipv6"

#SRC_TEST="do"


DEPEND="perl-core/Digest-MD5
		dev-perl/Digest-HMAC
		dev-perl/Net-IP
		ipv6? ( dev-perl/IO-Socket-INET6 )
		perl-core/MIME-Base64 || ( perl-core/Test-Simple >=dev-lang/perl-5.8.0-r12 )"
mydoc="TODO"

src_compile() {

	echo "n" | perl-module_src_compile
}
