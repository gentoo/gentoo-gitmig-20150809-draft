# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ObjectDriver/Data-ObjectDriver-0.06.ebuild,v 1.3 2009/10/27 09:09:22 volkmar Exp $

MODULE_AUTHOR="BTROTT"

inherit perl-module

DESCRIPTION="Simple, transparent data interface, with caching"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

RDEPEND="dev-perl/Test-Exception
	dev-perl/Class-Trigger
	dev-perl/Class-Data-Inheritable
	dev-perl/Class-Accessor
	dev-perl/DBI"
DEPEND="dev-perl/Test-Exception
		${RDEPEND}"

# testsuite is broken
SRC_TEST="never"
