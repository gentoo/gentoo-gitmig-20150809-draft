# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-SQLite/DBD-SQLite-1.00.ebuild,v 1.1 2004/07/30 09:52:34 mcummings Exp $

inherit perl-module

DESCRIPTION="Self Contained RDBMS in a DBI Driver"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/MS/MSERGEANT/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/DBI
		!<dev-perl/DBD-SQLite-1*"
