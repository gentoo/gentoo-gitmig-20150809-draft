# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract/SQL-Abstract-1.21.ebuild,v 1.4 2006/10/22 19:57:04 vivo Exp $

inherit perl-module
SRC_TEST="do"

DESCRIPTION="Generate SQL from Perl data structures"
HOMEPAGE="http://search.cpan.org/~nwiger/SQL-Abstract-1.20/"
SRC_URI="mirror://cpan/authors/id/N/NW/NWIGER/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
