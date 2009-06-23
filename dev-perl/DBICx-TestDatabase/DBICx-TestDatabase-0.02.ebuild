# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBICx-TestDatabase/DBICx-TestDatabase-0.02.ebuild,v 1.2 2009/06/23 13:47:01 tove Exp $

EAPI=2

MODULE_AUTHOR=JROCKWAY
inherit perl-module

DESCRIPTION="create a temporary database from a DBIx::Class::Schema"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-File-Temp
	dev-perl/DBD-SQLite
	dev-perl/SQL-Translator
"
DEPEND="${RDEPEND}
	test? ( dev-perl/DBIx-Class
		virtual/perl-Test-Simple
		dev-perl/Test-use-ok )"

SRC_TEST="do"
