# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Class/Exception-Class-1.26.ebuild,v 1.2 2008/11/18 14:53:32 tove Exp $

MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="Exception::Class module for perl"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

RDEPEND=">=dev-perl/Class-Data-Inheritable-0.02
	>=dev-perl/Devel-StackTrace-1.20
	dev-lang/perl"

DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28"
