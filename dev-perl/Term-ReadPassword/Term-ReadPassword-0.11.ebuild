# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ReadPassword/Term-ReadPassword-0.11.ebuild,v 1.2 2009/06/19 22:15:18 ranger Exp $

MODULE_AUTHOR=PHOENIX
inherit perl-module

DESCRIPTION="Term::ReadPassword - Asking the user for a password"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

# Tests are interactive
#SRC_TEST="do"

DEPEND="dev-lang/perl"
