# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Fatal/Test-Fatal-0.003.ebuild,v 1.7 2011/02/19 21:28:13 xarthisius Exp $

EAPI=3

MODULE_AUTHOR="RJBS"
inherit perl-module

DESCRIPTION="Incredibly simple helpers for testing code with exceptions"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Try-Tiny-0.07"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( >=virtual/perl-Test-Simple-0.96 )"

SRC_TEST="do"
