# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ObjectDriver/Data-ObjectDriver-0.06.ebuild,v 1.1 2009/09/08 11:37:35 robbat2 Exp $

MODULE_AUTHOR="BTROTT"

inherit perl-module

DESCRIPTION="Simple, transparent data interface, with caching"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-perl/Test-Exception
	dev-perl/Class-Trigger
	dev-perl/Class-Data-Inheritable
	dev-perl/Class-Accessor
	dev-perl/DBI"
DEPEND="dev-perl/Test-Exception
		${RDEPEND}"

# testsuite is broken
SRC_TEST="never"
