# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Package-Stash/Package-Stash-0.280.0.ebuild,v 1.1 2011/03/30 06:06:44 tove Exp $

EAPI=4

MODULE_AUTHOR=DOY
MODULE_VERSION=0.28
inherit perl-module

DESCRIPTION="Routines for manipulating stashes"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Package-DeprecationManager
	>=dev-perl/Package-Stash-XS-0.220"
# conflicts:
#	!<=dev-perl/Class-MOP-1.08
#	!<=dev-perl/namespace-clean-0.18
#	!<=dev-perl/MooseX-Role-WithOverloading-0.80

DEPEND="${RDEPEND}
	>=dev-perl/Dist-CheckConflicts-0.20
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? (
		dev-perl/Test-Fatal
		dev-perl/Test-Requires
		>=virtual/perl-Test-Simple-0.88
	)"

SRC_TEST="do"
