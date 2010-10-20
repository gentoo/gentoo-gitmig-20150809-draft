# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/dbix-searchbuilder/dbix-searchbuilder-1.58.ebuild,v 1.1 2010/10/20 16:47:03 tove Exp $

EAPI=3

MODULE_AUTHOR=RUZ
MY_PN=DBIx-SearchBuilder
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Encapsulate SQL queries and rows in simple perl objects"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="dev-perl/DBI
	dev-perl/DBIx-DBSchema
	dev-perl/Want
	>=dev-perl/Cache-Simple-TimedExpiry-0.21
	dev-perl/Clone
	dev-perl/Class-Accessor
	>=dev-perl/capitalization-0.03
	>=dev-perl/class-returnvalue-0.4"

DEPEND="test? ( ${RDEPEND}
		dev-perl/DBD-SQLite
		>=virtual/perl-Test-Simple-0.52 )"

SRC_TEST="do"
