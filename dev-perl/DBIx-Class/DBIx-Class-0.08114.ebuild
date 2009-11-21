# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class/DBIx-Class-0.08114.ebuild,v 1.1 2009/11/21 08:16:12 tove Exp $

EAPI=2

MODULE_AUTHOR="FREW"
inherit perl-module

DESCRIPTION="Extensible and flexible object <-> relational mapper"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Carp-Clan-6.00
	>=dev-perl/Class-Accessor-Grouped-0.09000
	>=dev-perl/Class-C3-Componentised-1.0005
	>=dev-perl/Class-Inspector-1.24
	>=dev-perl/Data-Page-2.01
	>=dev-perl/DBD-SQLite-1.25
	>=dev-perl/DBI-1.609
	>=virtual/perl-File-Temp-0.22
	>=dev-perl/JSON-Any-1.19
	>=dev-perl/MRO-Compat-0.11
	>=dev-perl/Module-Find-0.06
	dev-perl/Path-Class
	>=dev-perl/Scope-Guard-0.03
	>=dev-perl/SQL-Abstract-1.58
	>=dev-perl/SQL-Abstract-Limit-0.14.1
	>=dev-perl/Sub-Name-0.04
	dev-perl/Class-DBI-Plugin-DeepAbstractSearch
	>=dev-perl/Date-Simple-3.03
	dev-perl/DateTime-Format-SQLite
	>=dev-perl/Hash-Merge-0.11
	>=dev-perl/SQL-Translator-0.11002
	dev-perl/Time-Piece-MySQL
	>=dev-perl/Data-Dumper-Concise-1.000
"
DEPEND="${RDEPEND}
	test? (
		>=virtual/perl-Test-Simple-0.92
		dev-perl/Test-Deep
		dev-perl/Test-Exception
		>=dev-perl/Test-Warn-0.21
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
