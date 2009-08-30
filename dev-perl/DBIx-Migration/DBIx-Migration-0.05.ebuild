# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Migration/DBIx-Migration-0.05.ebuild,v 1.1 2009/08/30 18:22:16 tove Exp $

EAPI="2"

MODULE_AUTHOR=DANIEL
inherit perl-module

DESCRIPTION="Seamless DB schema up- and downgrades"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/File-Slurp
	virtual/perl-File-Spec
	dev-perl/DBI
	dev-perl/Class-Accessor"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

# needs DBD::SQLite2
SRC_TEST=no
