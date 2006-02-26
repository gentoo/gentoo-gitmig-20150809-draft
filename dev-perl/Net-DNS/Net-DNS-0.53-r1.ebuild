# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS/Net-DNS-0.53-r1.ebuild,v 1.8 2006/02/26 04:14:16 kumba Exp $

inherit perl-module

DESCRIPTION="Perl Net::DNS - Perl DNS Resolver Module"
SRC_URI="mirror://cpan/authors/id/O/OL/OLAF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~olaf/${P}/"

SLOT="0"
LICENSE="Artistic"
#KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
KEYWORDS="alpha ~amd64 ~mips ~ppc64 sparc x86"
IUSE="ipv6"

#SRC_TEST="do"


DEPEND="virtual/perl-Digest-MD5
		dev-perl/Digest-HMAC
		dev-perl/Net-IP
		ipv6? ( dev-perl/IO-Socket-INET6 )
		virtual/perl-MIME-Base64
		virtual/perl-Test-Simple"
mydoc="TODO"

src_compile() {

	echo "n" | perl-module_src_compile
}
