# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Load-Conditional/Module-Load-Conditional-0.28.ebuild,v 1.1 2008/12/23 08:45:02 robbat2 Exp $

MODULE_AUTHOR="KANE"

inherit perl-module

DESCRIPTION="Looking up module information / loading at runtime"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/Module-Load-0.12
	virtual/perl-Locale-Maketext-Simple
	dev-perl/Params-Check"
