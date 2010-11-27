# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-IniFiles/Config-IniFiles-2.65.ebuild,v 1.1 2010/11/27 20:46:30 tove Exp $

EAPI=3

MODULE_AUTHOR=SHLOMIF
inherit perl-module

DESCRIPTION="A module for reading .ini-style configuration files"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="dev-perl/IO-stringy"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.36
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
