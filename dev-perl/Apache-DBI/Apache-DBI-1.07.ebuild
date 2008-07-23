# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-DBI/Apache-DBI-1.07.ebuild,v 1.1 2008/07/23 08:42:12 tove Exp $

MODULE_AUTHOR=PGOLLUCCI
inherit perl-module

DESCRIPTION="Apache::DBI module for perl"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-Test-Simple
	>=dev-perl/Digest-SHA1-2.01
	>=dev-perl/DBI-1.30
	dev-lang/perl"

export OPTIMIZE="$CFLAGS"
