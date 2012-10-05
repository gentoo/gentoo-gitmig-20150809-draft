# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-MockModule/Test-MockModule-0.50.0.ebuild,v 1.5 2012/10/05 15:34:18 ranger Exp $

EAPI=4

MODULE_VERSION=0.05
MODULE_AUTHOR="SIMONFLK"
inherit perl-module

DESCRIPTION="Override subroutines in a module for unit testing"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
