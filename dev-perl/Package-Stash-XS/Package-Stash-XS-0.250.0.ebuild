# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Package-Stash-XS/Package-Stash-XS-0.250.0.ebuild,v 1.5 2011/11/07 07:56:45 grobian Exp $

EAPI=4

MODULE_AUTHOR=DOY
MODULE_VERSION=0.25
inherit perl-module

DESCRIPTION="Faster and more correct implementation of the Package::Stash API"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~x86-freebsd ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? (
		dev-perl/Test-Fatal
		>=virtual/perl-Test-Simple-0.88
	)"

SRC_TEST="do"
