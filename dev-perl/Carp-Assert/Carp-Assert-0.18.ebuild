# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Carp-Assert/Carp-Assert-0.18.ebuild,v 1.2 2005/01/21 20:07:08 mcummings Exp $

inherit perl-module

DESCRIPTION="executable comments in carp"
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Test-Simple"
