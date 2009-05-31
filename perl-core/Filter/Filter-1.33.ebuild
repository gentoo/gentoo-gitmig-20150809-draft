# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Filter/Filter-1.33.ebuild,v 1.8 2009/05/31 08:16:35 tove Exp $

inherit perl-module

DESCRIPTION="Interface for creation of Perl Filters"
HOMEPAGE="http://search.cpan.org/~pmqs/${P}.readme"
SRC_URI="mirror://cpan/authors/id/P/PM/PMQS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
