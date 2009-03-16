# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Algorithm-Munkres/Algorithm-Munkres-0.08.ebuild,v 1.2 2009/03/16 01:59:19 weaver Exp $

inherit perl-module

DESCRIPTION="Munkres solution to classical Assignment problem"
HOMEPAGE="http://search.cpan.org/~tpederse/${P}/lib/Algorithm/Munkres.pm"
SRC_URI="mirror://cpan/authors/id/T/TP/TPEDERSE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
SRC_TEST="do"

DEPEND="dev-lang/perl"
