# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-SQLite/DBD-SQLite-1.11.ebuild,v 1.8 2006/04/21 21:15:07 gustavoz Exp $

inherit perl-module eutils

DESCRIPTION="Self Contained RDBMS in a DBI Driver"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/DBI-1.42
		!<dev-perl/DBD-SQLite-1"
