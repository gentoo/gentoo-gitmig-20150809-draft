# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract/SQL-Abstract-1.22.ebuild,v 1.4 2007/01/22 14:27:52 kloeri Exp $

inherit perl-module
SRC_TEST="do"

DESCRIPTION="Generate SQL from Perl data structures"
HOMEPAGE="http://search.cpan.org/~nwiger/"
SRC_URI="mirror://cpan/authors/id/N/NW/NWIGER/${P}.tgz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
