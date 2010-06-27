# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Array-Compare/Array-Compare-2.01.ebuild,v 1.6 2010/06/27 18:59:04 nixnut Exp $

EAPI=2

MODULE_AUTHOR=DAVECROSS
inherit perl-module

DESCRIPTION="Perl extension for comparing arrays."

SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

SRC_TEST="do"

RDEPEND="dev-perl/Moose"
DEPEND=">=virtual/perl-Module-Build-0.28
	test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"
