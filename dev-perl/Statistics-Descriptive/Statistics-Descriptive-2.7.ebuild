# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Statistics-Descriptive/Statistics-Descriptive-2.7.ebuild,v 1.2 2009/05/13 17:29:43 weaver Exp $

EAPI=2

MODULE_AUTHOR=SHLOMIF
inherit perl-module

DESCRIPTION="Module of basic descriptive statistical functions"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/perl-Module-Build"
RDEPEND=""

SRC_TEST="do"
mydoc="UserSurvey.txt"
