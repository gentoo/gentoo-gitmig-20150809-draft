# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Override/Sub-Override-0.80.0.ebuild,v 1.1 2011/08/28 18:57:30 tove Exp $

EAPI=4

MODULE_AUTHOR=OVID
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="Perl extension for easily overriding subroutines"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-linux"
IUSE="test"

DEPEND="
	test? (
		virtual/perl-Test-Simple
		>=dev-perl/Test-Exception-0.21
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
