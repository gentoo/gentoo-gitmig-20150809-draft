# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS/Net-DNS-0.53.ebuild,v 1.4 2006/03/12 07:52:00 vapier Exp $

inherit perl-module

DESCRIPTION="Perl Net::DNS - Perl DNS Resolver Module"
HOMEPAGE="http://search.cpan.org/~olaf/${P}/"
SRC_URI="mirror://cpan/authors/id/O/OL/OLAF/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="virtual/perl-Digest-MD5
	dev-perl/Digest-HMAC
	dev-perl/Net-IP
	virtual/perl-MIME-Base64
	virtual/perl-Test-Simple"

#SRC_TEST="do"
mydoc="TODO"

src_compile() {
	echo "n" | perl-module_src_compile
}
