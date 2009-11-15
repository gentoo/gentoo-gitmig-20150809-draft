# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI-Plugin/Class-DBI-Plugin-0.03.ebuild,v 1.2 2009/11/15 00:38:34 robbat2 Exp $

MODULE_AUTHOR="JCZEUS"

inherit perl-module

DESCRIPTION="Abstract base class for Class::DBI plugins"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Class-DBI
	dev-lang/perl"
SRC_TEST=do
