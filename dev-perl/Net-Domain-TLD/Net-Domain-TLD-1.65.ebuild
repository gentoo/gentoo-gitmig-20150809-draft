# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Domain-TLD/Net-Domain-TLD-1.65.ebuild,v 1.1 2006/05/01 21:10:41 mcummings Exp $

inherit perl-module

DESCRIPTION="Gives ability to retrieve currently available tld names/descriptions and perform verification of given tld name"
HOMEPAGE="http://search.cpan.org/~rjbs/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AL/ALEXP/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~mips"
IUSE=""

TDEPEND=">=dev-perl/Test-Pod-Coverage-1.04"

SRC_TEST="do"
