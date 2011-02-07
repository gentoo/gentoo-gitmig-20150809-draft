# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Natural/DateTime-Format-Natural-0.930.ebuild,v 1.1 2011/02/07 18:28:36 robbat2 Exp $

EAPI=3

MODULE_AUTHOR=SCHUBIGER
MODULE_VERSION=${PV:0:4}
inherit perl-module

DESCRIPTION="Create machine readable date/time with natural parsing logic"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/boolean
	dev-perl/DateTime
	dev-perl/Date-Calc
	virtual/perl-Getopt-Long
	dev-perl/Params-Validate
	dev-perl/List-MoreUtils"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Module-Util
		dev-perl/Test-MockTime
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
