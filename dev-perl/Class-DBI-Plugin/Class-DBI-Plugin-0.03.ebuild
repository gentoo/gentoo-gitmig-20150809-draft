# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI-Plugin/Class-DBI-Plugin-0.03.ebuild,v 1.3 2011/04/24 15:36:59 grobian Exp $

MODULE_AUTHOR="JCZEUS"

inherit perl-module

DESCRIPTION="Abstract base class for Class::DBI plugins"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86 ~x86-solaris"

DEPEND="dev-perl/Class-DBI
	dev-lang/perl"
SRC_TEST=do
