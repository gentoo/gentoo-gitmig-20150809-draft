# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Role-Parameterized/MooseX-Role-Parameterized-0.270.0.ebuild,v 1.2 2011/09/24 13:17:18 grobian Exp $

EAPI=4

MODULE_AUTHOR=SARTAK
MODULE_VERSION=0.27
inherit perl-module

DESCRIPTION="Roles with composition parameters"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE="test"

RDEPEND="
	>=dev-perl/Moose-0.78
"
DEPEND="
	${RDEPEND}
	test? (
		>=virtual/perl-Test-Simple-0.96
		dev-perl/Test-Fatal
	)
"
SRC_TEST="do"
