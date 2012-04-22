# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Std/Class-Std-0.11.0.ebuild,v 1.1 2012/04/22 10:34:20 tove Exp $

EAPI="4"

MODULE_AUTHOR="DCONWAY"
MODULE_VERSION=0.011
inherit perl-module

DESCRIPTION='Support for creating standard "inside-out" classes'

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-Data-Dumper
	virtual/perl-Scalar-List-Utils
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
