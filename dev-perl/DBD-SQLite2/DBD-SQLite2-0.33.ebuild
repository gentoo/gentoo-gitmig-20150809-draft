# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-SQLite2/DBD-SQLite2-0.33.ebuild,v 1.4 2006/07/04 07:13:32 ian Exp $

inherit perl-module

DESCRIPTION="Self Contained RDBMS in a DBI Driver (sqlite 2.x)"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"

LICENSE="Artistic"
#LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~ia64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/DBI"
RDEPEND="${DEPEND}"