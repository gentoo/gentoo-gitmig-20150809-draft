# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-ErrorString-Perl/Parse-ErrorString-Perl-0.13.ebuild,v 1.1 2010/02/15 13:20:13 tove Exp $

EAPI=2

MODULE_AUTHOR=SZABGAB
inherit perl-module

DESCRIPTION="Parse error messages from the perl interpreter"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Class-XSAccessor
	virtual/perl-PodParser
	dev-perl/Pod-POM"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Differences )"

SRC_TEST=do
