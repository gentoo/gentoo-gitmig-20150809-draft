# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Fatal/Test-Fatal-0.003.ebuild,v 1.2 2010/11/28 19:18:02 armin76 Exp $

EAPI=3

MODULE_AUTHOR="RJBS"
inherit perl-module

DESCRIPTION="Incredibly simple helpers for testing code with exceptions"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Try-Tiny-0.07"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( >=virtual/perl-Test-Simple-0.96 )"

SRC_TEST="do"
