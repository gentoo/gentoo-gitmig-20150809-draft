# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class/DBIx-Class-0.08108.ebuild,v 1.1 2009/07/18 09:08:17 tove Exp $

EAPI=2

MODULE_AUTHOR="RIBASUSHI"
inherit perl-module

DESCRIPTION="Extensible and flexible object <-> relational mapper"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Carp-Clan
	>=dev-perl/Class-Accessor-Grouped-0.08003
	>=dev-perl/Class-C3-Componentised-1.0005
	dev-perl/Class-Inspector
	>=dev-perl/Data-Page-2.01
	>=dev-perl/DBD-SQLite-1.25
	>=dev-perl/DBI-1.609
	>=dev-perl/JSON-Any-1.19
	>=dev-perl/MRO-Compat-0.11
	>=dev-perl/Module-Find-0.06
	dev-perl/Path-Class
	>=dev-perl/Scope-Guard-0.03
	>=dev-perl/SQL-Abstract-1.56
	>=dev-perl/SQL-Abstract-Limit-0.14.1
	>=dev-perl/Sub-Name-0.04
"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Deep
		dev-perl/Test-Exception
		>=dev-perl/Test-Warn-0.11
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

#SRC_TEST=do
