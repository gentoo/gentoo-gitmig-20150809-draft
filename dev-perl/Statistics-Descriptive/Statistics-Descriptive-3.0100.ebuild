# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Statistics-Descriptive/Statistics-Descriptive-3.0100.ebuild,v 1.6 2012/05/28 15:50:04 armin76 Exp $

EAPI=2

MODULE_AUTHOR=SHLOMIF
inherit perl-module

DESCRIPTION="Module of basic descriptive statistical functions"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="test"

DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"
RDEPEND=""

SRC_TEST="do"
mydoc="UserSurvey.txt"
