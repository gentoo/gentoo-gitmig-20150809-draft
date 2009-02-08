# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Load/Module-Load-0.16.ebuild,v 1.1 2009/02/08 09:16:46 tove Exp $

MODULE_AUTHOR="KANE"
inherit perl-module

DESCRIPTION="runtime require of both modules and files"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST=do
