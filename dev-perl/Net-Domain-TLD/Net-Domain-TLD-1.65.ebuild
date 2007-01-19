# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Domain-TLD/Net-Domain-TLD-1.65.ebuild,v 1.9 2007/01/19 14:51:15 mcummings Exp $

inherit perl-module

DESCRIPTION="Gives ability to retrieve currently available tld names/descriptions and perform verification of given tld name"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/A/AL/ALEXP/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ~ppc64 sparc ~x86"
IUSE=""

TDEPEND=">=dev-perl/Test-Pod-Coverage-1.04"
DEPEND="dev-lang/perl"

SRC_TEST="do"
