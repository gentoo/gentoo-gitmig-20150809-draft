# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-IniFiles/Config-IniFiles-2.46.ebuild,v 1.1 2009/01/19 10:18:26 tove Exp $

MODULE_AUTHOR=SHLOMIF
inherit perl-module

DESCRIPTION="A module for reading .ini-style configuration files"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Harness )"

SRC_TEST="do"
