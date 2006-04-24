# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS/Net-DNS-0.53-r1.ebuild,v 1.13 2006/04/24 05:16:40 kumba Exp $

inherit perl-module

DESCRIPTION="Perl Net::DNS - Perl DNS Resolver Module"
HOMEPAGE="http://search.cpan.org/~olaf/${P}/"
SRC_URI="mirror://cpan/authors/id/O/OL/OLAF/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 m68k mips ppc64 s390 sh sparc x86"
IUSE="ipv6"

DEPEND="virtual/perl-Digest-MD5
	dev-perl/Digest-HMAC
	dev-perl/Net-IP
	ipv6? ( dev-perl/IO-Socket-INET6 )
	virtual/perl-MIME-Base64
	virtual/perl-Test-Simple"

#SRC_TEST="do"
mydoc="TODO"

src_compile() {
	echo "n" | perl-module_src_compile
}
