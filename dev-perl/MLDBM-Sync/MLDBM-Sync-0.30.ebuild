# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MLDBM-Sync/MLDBM-Sync-0.30.ebuild,v 1.9 2010/04/26 20:15:32 maekke Exp $

MODULE_AUTHOR=CHAMAS
inherit perl-module

DESCRIPTION="Safe concurrent access to MLDBM databases"

SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 sparc x86"
IUSE="test"

RDEPEND="dev-lang/perl
		dev-perl/MLDBM"
DEPEND="${RDEPEND}
		test? ( virtual/perl-Test-Harness )"

SRC_TEST="do"
