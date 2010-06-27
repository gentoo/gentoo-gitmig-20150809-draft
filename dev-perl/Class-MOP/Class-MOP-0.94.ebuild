# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MOP/Class-MOP-0.94.ebuild,v 1.4 2010/06/27 17:59:08 nixnut Exp $

EAPI=2

MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="A Meta Object Protocol for Perl 5"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="test"

RDEPEND="
	>=virtual/perl-Scalar-List-Utils-1.18
	>=dev-perl/Sub-Name-0.04
	>=dev-perl/Sub-Identify-0.03
	>=dev-perl/MRO-Compat-0.05
	dev-perl/Devel-GlobalDestruction"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-CBuilder
	test? ( >=virtual/perl-Test-Simple-0.88
		>=dev-perl/Test-Exception-0.27
		dev-perl/Test-Output )"

SRC_TEST=do
