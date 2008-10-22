# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Versions-Report/Module-Versions-Report-1.06.ebuild,v 1.1 2008/10/22 09:33:19 tove Exp $

MODULE_AUTHOR=JESSE
inherit perl-module

DESCRIPTION="Report versions of all modules in memory"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
