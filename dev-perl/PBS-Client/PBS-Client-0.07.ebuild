# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PBS-Client/PBS-Client-0.07.ebuild,v 1.1 2009/04/30 15:53:44 weaver Exp $

EAPI=2

inherit perl-module

DESCRIPTION="Perl interface to submit jobs to PBS (Portable Batch System)"
HOMEPAGE="http://search.cpan.org/~kwmak/${P}/lib/PBS/Client.pm"
SRC_URI="mirror://cpan/authors/id/K/KW/KWMAK/PBS/Client/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Class-MethodMaker"
RDEPEND="${DEPEND}"

SRC_TEST="do"
