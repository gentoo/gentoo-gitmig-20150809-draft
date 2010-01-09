# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-SQLite/DBD-SQLite-1.29.ebuild,v 1.1 2010/01/09 09:25:04 tove Exp $

EAPI=2

MODULE_AUTHOR=ADAMK
inherit perl-module eutils

DESCRIPTION="Self Contained RDBMS in a DBI Driver"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND=">=dev-perl/DBI-1.57
	!<dev-perl/DBD-SQLite-1"

SRC_TEST="do"
