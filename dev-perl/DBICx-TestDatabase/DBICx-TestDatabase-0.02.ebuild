# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBICx-TestDatabase/DBICx-TestDatabase-0.02.ebuild,v 1.1 2009/06/23 07:35:57 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="JROCKWAY"

inherit perl-module

DESCRIPTION="create a temporary database from a DBIx::Class::Schema"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/SQL-Translator
	dev-perl/DBD-SQLite
	dev-perl/DBIx-Class"
RDEPEND="${DEPEND}"
