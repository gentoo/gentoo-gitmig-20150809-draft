# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI-Plugin-DeepAbstractSearch/Class-DBI-Plugin-DeepAbstractSearch-0.08.ebuild,v 1.2 2011/04/24 15:46:31 grobian Exp $

MODULE_AUTHOR="SRIHA"

inherit perl-module

DESCRIPTION="deep_search_where() method for Class::DBI"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86 ~x86-solaris"

DEPEND=">=dev-perl/Class-DBI-Plugin-0.03
	>=dev-perl/SQL-Abstract-1.60
	dev-perl/Class-DBI
	dev-lang/perl"
SRC_TEST=do
