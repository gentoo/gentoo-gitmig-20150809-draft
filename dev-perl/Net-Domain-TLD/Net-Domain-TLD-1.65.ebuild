# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Domain-TLD/Net-Domain-TLD-1.65.ebuild,v 1.12 2011/12/04 18:02:16 armin76 Exp $

inherit perl-module

DESCRIPTION="Gives ability to retrieve currently available tld names/descriptions and perform verification of given tld name"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/A/AL/ALEXP/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ppc ppc64 x86"
IUSE=""

TDEPEND=">=dev-perl/Test-Pod-Coverage-1.04"
DEPEND="dev-lang/perl"

SRC_TEST="do"
