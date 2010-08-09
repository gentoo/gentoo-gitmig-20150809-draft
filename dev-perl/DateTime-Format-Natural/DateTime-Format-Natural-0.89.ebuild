# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Natural/DateTime-Format-Natural-0.89.ebuild,v 1.1 2010/08/09 13:20:05 tove Exp $

EAPI=3

MODULE_AUTHOR=SCHUBIGER
inherit perl-module

DESCRIPTION="Create machine readable date/time with natural parsing logic"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/boolean
	dev-perl/DateTime
	dev-perl/Date-Calc
	dev-perl/Params-Validate
	dev-perl/List-MoreUtils"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-MockTime
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
