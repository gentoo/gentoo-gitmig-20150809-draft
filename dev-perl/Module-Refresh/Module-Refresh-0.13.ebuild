# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Refresh/Module-Refresh-0.13.ebuild,v 1.6 2010/06/27 18:30:46 nixnut Exp $

MODULE_AUTHOR=JESSE
inherit perl-module

DESCRIPTION="Refresh %INC files when updated on disk"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
