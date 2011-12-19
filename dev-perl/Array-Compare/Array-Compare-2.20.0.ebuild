# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Array-Compare/Array-Compare-2.20.0.ebuild,v 1.1 2011/12/19 16:04:01 tove Exp $

EAPI=4

MODULE_AUTHOR=DAVECROSS
MODULE_VERSION=2.02
inherit perl-module

DESCRIPTION="Perl extension for comparing arrays"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

SRC_TEST="do"

RDEPEND="dev-perl/Moose"
DEPEND=">=virtual/perl-Module-Build-0.28
	test? ( ${RDEPEND}
		dev-perl/Test-NoWarnings
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"
