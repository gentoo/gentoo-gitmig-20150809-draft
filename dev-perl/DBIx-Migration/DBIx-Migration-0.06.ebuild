# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Migration/DBIx-Migration-0.06.ebuild,v 1.1 2010/10/20 16:53:22 tove Exp $

EAPI=3

MODULE_AUTHOR=DANIEL
inherit perl-module

DESCRIPTION="Seamless DB schema up- and downgrades"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/File-Slurp
	virtual/perl-File-Spec
	dev-perl/DBI
	dev-perl/Class-Accessor"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/DBD-SQLite
	)"

SRC_TEST=do
