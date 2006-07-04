# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS/Net-DNS-0.49.ebuild,v 1.17 2006/07/04 13:34:37 ian Exp $

inherit perl-module

DESCRIPTION="Perl Net::DNS - Perl DNS Resolver Module"
SRC_URI="mirror://cpan/authors/id/O/OL/OLAF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~crein/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

#SRC_TEST="do"


DEPEND="virtual/perl-Digest-MD5
		dev-perl/Digest-HMAC
		virtual/perl-MIME-Base64
		virtual/perl-Test-Simple"
RDEPEND="${DEPEND}"
mydoc="TODO"

src_compile() {

	echo "n" | perl-module_src_compile
}