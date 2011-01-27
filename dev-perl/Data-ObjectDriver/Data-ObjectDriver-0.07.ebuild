# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ObjectDriver/Data-ObjectDriver-0.07.ebuild,v 1.5 2011/01/27 16:19:46 ranger Exp $

EAPI=2

MODULE_AUTHOR=SIXAPART
inherit perl-module

DESCRIPTION="Simple, transparent data interface, with caching"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE="test"

RDEPEND="dev-perl/Class-Trigger
	dev-perl/Class-Data-Inheritable
	dev-perl/Class-Accessor
	dev-perl/DBI"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Exception
		dev-perl/DBD-SQLite )"

SRC_TEST=do
