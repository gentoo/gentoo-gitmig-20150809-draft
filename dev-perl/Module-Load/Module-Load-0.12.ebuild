# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Load/Module-Load-0.12.ebuild,v 1.2 2009/01/17 22:28:28 robbat2 Exp $

MODULE_AUTHOR="KANE"

inherit perl-module

DESCRIPTION="runtime require of both modules and files"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
