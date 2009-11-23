# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ObjectDriver/Data-ObjectDriver-0.06.ebuild,v 1.4 2009/11/23 17:38:28 tove Exp $

EAPI=2

MODULE_AUTHOR="BTROTT"
inherit perl-module

DESCRIPTION="Simple, transparent data interface, with caching"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Class-Trigger
	dev-perl/Class-Data-Inheritable
	dev-perl/Class-Accessor
	dev-perl/DBI"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
#	test? ( dev-perl/Test-Exception )"

# testsuite is broken
SRC_TEST="never"
