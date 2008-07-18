# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Warn/Test-Warn-0.11.ebuild,v 1.1 2008/07/18 14:37:09 tove Exp $

MODULE_AUTHOR=CHORNY
inherit perl-module

DESCRIPTION="Perl extension to test methods for warnings"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Test-Exception
	>=dev-perl/Sub-Uplevel-0.09-r1
	dev-perl/Array-Compare
	dev-perl/Tree-DAG_Node
	virtual/perl-Test-Simple
	virtual/perl-File-Spec
	dev-lang/perl"
