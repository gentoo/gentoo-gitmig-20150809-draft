# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Override/Sub-Override-0.08.ebuild,v 1.13 2011/07/29 22:21:17 zmedico Exp $

EAPI=2

MODULE_AUTHOR=OVID
inherit perl-module

DESCRIPTION="Perl extension for easily overriding subroutines"

SLOT="0"
KEYWORDS="amd64 ia64 ppc ~ppc64 sparc x86 ~x86-linux"
IUSE="test"

RDEPEND=""
DEPEND="test? ( virtual/perl-Test-Simple
	>=dev-perl/Test-Exception-0.21
	dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
