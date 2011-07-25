# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Statistics-Descriptive/Statistics-Descriptive-3.20.200.ebuild,v 1.1 2011/07/25 09:06:38 tove Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=3.0202
inherit perl-module

DESCRIPTION="Module of basic descriptive statistical functions"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
mydoc="UserSurvey.txt"
