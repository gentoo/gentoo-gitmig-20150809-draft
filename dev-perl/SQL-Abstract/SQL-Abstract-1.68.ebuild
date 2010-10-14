# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract/SQL-Abstract-1.68.ebuild,v 1.3 2010/10/14 19:27:18 ranger Exp $

EAPI=3

MODULE_AUTHOR="FREW"
#MODULE_AUTHOR="RIBASUSHI"
#MODULE_AUTHOR="MSTROUT"
inherit perl-module

DESCRIPTION="Generate SQL from Perl data structures"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Class-Accessor-Grouped
	dev-perl/Hash-Merge"
DEPEND="${RDEPEND}
	test? ( >=dev-perl/Test-Deep-0.106
		dev-perl/Test-Exception
		dev-perl/Test-Pod
		>=virtual/perl-Test-Simple-0.92
		dev-perl/Test-Warn
		>=dev-perl/Clone-0.31 )"
#		dev-perl/Test-Pod-Coverage
SRC_TEST="do"
