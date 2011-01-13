# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Package-Stash-XS/Package-Stash-XS-0.200.ebuild,v 1.1 2011/01/13 20:02:17 tove Exp $

EAPI=3

MODULE_AUTHOR=DOY
MODULE_VERSION=0.20
inherit perl-module

DESCRIPTION="Faster and more correct implementation of the Package::Stash API"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? (
		dev-perl/Test-Fatal
		>=virtual/perl-Test-Simple-0.88
	)"

SRC_TEST="do"
