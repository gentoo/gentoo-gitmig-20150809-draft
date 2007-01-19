# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Stat-lsMode/Stat-lsMode-0.50.ebuild,v 1.17 2007/01/19 15:50:58 mcummings Exp $

inherit perl-module

DESCRIPTION="The Perl Stat-lsMode Module"
SRC_URI="mirror://cpan/authors/id/M/MJ/MJD/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mjd/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
SRC_TEST="do"


DEPEND="dev-lang/perl"
