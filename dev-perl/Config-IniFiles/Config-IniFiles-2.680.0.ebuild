# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-IniFiles/Config-IniFiles-2.680.0.ebuild,v 1.2 2012/05/12 16:33:33 armin76 Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=2.68
inherit perl-module

DESCRIPTION="A module for reading .ini-style configuration files"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="dev-perl/IO-stringy"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.36
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
