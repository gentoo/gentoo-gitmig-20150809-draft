# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-SQLite/DBD-SQLite-1.06.ebuild,v 1.3 2004/10/16 23:57:21 rac Exp $

inherit perl-module eutils

DESCRIPTION="Self Contained RDBMS in a DBI Driver"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/DBI-1.42
		!<dev-perl/DBD-SQLite-1*"

src_unpack() {
	unpack ${A}
	cd ${S}
	# This horrible patch was gleamed from:
	# http://www.sqlite.org/cvstrac/chngview?cn=2002
	# http://www.sqlite.org/cvstrac/tktview?tn=700
	# Any eager C coders out there are welcome to submit a "real" fix
	# 2004/Oct/05 mcummings
	use sparc && epatch ${FILESDIR}/sparc-DBD-SQLite-1.06.patch
	perl-module_src_prep
}
