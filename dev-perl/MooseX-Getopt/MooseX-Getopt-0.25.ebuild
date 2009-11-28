# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Getopt/MooseX-Getopt-0.25.ebuild,v 1.1 2009/11/28 02:01:27 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=BOBTFISH
inherit perl-module

DESCRIPTION="A Moose role for processing command line options"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Moose-0.56
	>=dev-perl/Getopt-Long-Descriptive-0.077
	>=virtual/perl-Getopt-Long-2.37"
DEPEND="${RDEPEND}
	test? ( >=dev-perl/Test-Exception-0.21
		>=virtual/perl-Test-Simple-0.62 )"

SRC_TEST=do
