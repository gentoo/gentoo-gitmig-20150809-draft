# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-RBLClient/Net-RBLClient-0.5.ebuild,v 1.4 2007/08/14 18:03:38 corsair Exp $

inherit perl-module

DESCRIPTION="Net::RBLClient - Queries multiple Realtime Blackhole Lists in parallel"
HOMEPAGE="http://search.cpan.org/~ablum/${PN}/"
SRC_URI="mirror://cpan/authors/id/A/AB/ABLUM/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="virtual/perl-Time-HiRes
	dev-perl/Net-DNS"

S="${WORKDIR}/RBLCLient-${PV}" # second capitialized 'l' is deliberate
