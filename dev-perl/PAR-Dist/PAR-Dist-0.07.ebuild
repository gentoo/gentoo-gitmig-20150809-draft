# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PAR-Dist/PAR-Dist-0.07.ebuild,v 1.4 2006/08/20 01:18:24 mcummings Exp $

inherit perl-module

DESCRIPTION="Create and manipulate PAR distributions"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="sparc ~x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
