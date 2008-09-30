# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-2.9007.ebuild,v 1.17 2008/09/30 23:25:00 robbat2 Exp $

MODULE_AUTHOR="CAPTTOFU"
inherit perl-module

DESCRIPTION="The Perl DBD:mysql Module"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"

IUSE=""

DEPEND="dev-perl/DBI
	virtual/mysql
	dev-lang/perl"

mydoc="ToDo"
