# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI-Plugin-DeepAbstractSearch/Class-DBI-Plugin-DeepAbstractSearch-0.08.ebuild,v 1.1 2009/11/15 00:38:47 robbat2 Exp $

MODULE_AUTHOR="SRIHA"

inherit perl-module

DESCRIPTION="deep_search_where() method for Class::DBI"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/Class-DBI-Plugin-0.03
	>=dev-perl/SQL-Abstract-1.60
	dev-perl/Class-DBI
	dev-lang/perl"
SRC_TEST=do
