# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-XSBuilder/ExtUtils-XSBuilder-0.25.ebuild,v 1.1 2004/05/02 00:27:08 mcummings Exp $

inherit perl-module

DESCRIPTION="Modules to parse C header files and create XS glue code."
SRC_URI="http://cpan.org/CPAN/authors/id/G/GR/GRICHTER/${P}.tar.gz"
HOMEPAGE="http://cpan.org/CPAN/authors/id/G/GR/GRICHTER/${P}.readme"
IUSE=""
SLOT="0"
SRC_TEST="do"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
DEPEND="dev-perl/Parse-RecDescent
		dev-perl/Tie-IxHash"
