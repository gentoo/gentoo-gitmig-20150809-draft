# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Filter/Filter-1.28-r1.ebuild,v 1.10 2005/01/04 13:01:40 mcummings Exp $

inherit perl-module

DESCRIPTION="Source Filters for Perl"
HOMEPAGE="http://search.cpan.org/~pmqs/${P}.readme"
SRC_URI="mirror://cpan/authors/id/P/PM/PMQS/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

mymake="/usr"
