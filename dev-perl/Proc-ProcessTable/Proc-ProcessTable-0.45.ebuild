# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-ProcessTable/Proc-ProcessTable-0.45.ebuild,v 1.3 2009/01/25 14:30:44 maekke Exp $

MODULE_AUTHOR=DURIST
inherit perl-module

DESCRIPTION="Unix process table information"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-Storable
	dev-lang/perl"
