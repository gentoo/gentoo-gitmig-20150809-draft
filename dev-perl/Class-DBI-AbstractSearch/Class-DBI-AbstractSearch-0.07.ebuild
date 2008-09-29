# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI-AbstractSearch/Class-DBI-AbstractSearch-0.07.ebuild,v 1.1 2008/09/29 02:06:41 robbat2 Exp $

MODULE_AUTHOR="MIYAGAWA"

inherit perl-module

DESCRIPTION="Abstract Class::DBI's SQL with SQL::Abstract::Limit"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-perl/SQL-Abstract-Limit-0.12
	dev-perl/Class-DBI"
