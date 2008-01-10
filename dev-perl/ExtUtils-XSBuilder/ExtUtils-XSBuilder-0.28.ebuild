# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-XSBuilder/ExtUtils-XSBuilder-0.28.ebuild,v 1.12 2008/01/10 17:00:57 ranger Exp $

inherit perl-module

DESCRIPTION="Modules to parse C header files and create XS glue code."
SRC_URI="mirror://cpan/authors/id/G/GR/GRICHTER/${P}.tar.gz"
HOMEPAGE="http://cpan.org/CPAN/authors/id/G/GR/GRICHTER/${P}.readme"
IUSE=""
SLOT="0"
SRC_TEST="do"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
DEPEND="dev-perl/Parse-RecDescent
	dev-perl/Tie-IxHash
	dev-lang/perl"
