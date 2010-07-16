# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Getopt/MooseX-Getopt-0.31.ebuild,v 1.1 2010/07/16 07:03:35 tove Exp $

EAPI=3

MODULE_AUTHOR=BOBTFISH
inherit perl-module

DESCRIPTION="A Moose role for processing command line options"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Moose-0.56
	>=dev-perl/Getopt-Long-Descriptive-0.081
	>=virtual/perl-Getopt-Long-2.37"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( >=dev-perl/Test-Exception-0.21
		>=virtual/perl-Test-Simple-0.62
		>=dev-perl/Test-Warn-0.21 )"

SRC_TEST=do
