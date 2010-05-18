# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-Sub/Tie-Sub-0.09.ebuild,v 1.2 2010/05/18 07:00:04 tove Exp $

EAPI=2

MODULE_AUTHOR=STEFFENW
inherit perl-module

DESCRIPTION="Tying a subroutine, function or method to a hash"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Params-Validate"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-NoWarnings
		dev-perl/Test-Exception
		>=dev-perl/Test-Pod-1.14
		>=dev-perl/Test-Pod-Coverage-1.04
		virtual/perl-Test-Simple
	)"

SRC_TEST="do"
