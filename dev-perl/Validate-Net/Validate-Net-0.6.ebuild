# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Validate-Net/Validate-Net-0.6.ebuild,v 1.1 2008/07/18 14:52:15 tove Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Format validation and more for Net:: related strings"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE="test"

SRC_TEST="do"

RDEPEND="dev-perl/Class-Default
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"
