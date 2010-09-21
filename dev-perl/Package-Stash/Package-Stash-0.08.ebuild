# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Package-Stash/Package-Stash-0.08.ebuild,v 1.1 2010/09/21 17:59:52 tove Exp $

EAPI=3

MODULE_AUTHOR="DOY"
inherit perl-module

DESCRIPTION="Routines for manipulating stashes"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( dev-perl/Test-Exception
		>=virtual/perl-Test-Simple-0.88 )"

SRC_TEST="do"
