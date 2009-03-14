# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract/SQL-Abstract-1.50.ebuild,v 1.1 2009/03/14 21:02:59 robbat2 Exp $

MODULE_AUTHOR="MSTROUT"
inherit perl-module
SRC_TEST="do"

DESCRIPTION="Generate SQL from Perl data structures"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="test"

DEPEND="dev-lang/perl
		test? ( dev-perl/Test-Deep )"
