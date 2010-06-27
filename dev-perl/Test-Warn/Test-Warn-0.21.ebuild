# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Warn/Test-Warn-0.21.ebuild,v 1.6 2010/06/27 19:21:20 nixnut Exp $

EAPI=2

MODULE_AUTHOR=CHORNY
MODULE_A=${P}.zip
inherit perl-module

DESCRIPTION="Perl extension to test methods for warnings"

SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=">=dev-perl/Sub-Uplevel-0.12
	dev-perl/Tree-DAG_Node
	virtual/perl-Test-Simple
	virtual/perl-File-Spec"
DEPEND="app-arch/unzip
	test? ( ${RDEPEND}
		dev-perl/Test-Pod )"

SRC_TEST="do"
