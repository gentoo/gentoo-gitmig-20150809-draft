# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-SQLite/DBD-SQLite-0.31-r1.ebuild,v 1.5 2011/07/30 10:23:21 tove Exp $

MODULE_AUTHOR=MSERGEANT
inherit perl-module

DESCRIPTION="Self Contained RDBMS in a DBI Driver"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~ppc sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/DBI
	dev-lang/perl"
