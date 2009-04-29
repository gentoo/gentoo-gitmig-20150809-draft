# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract/SQL-Abstract-1.52.ebuild,v 1.1 2009/04/29 08:04:03 tove Exp $

EAPI=2

MODULE_AUTHOR="MSTROUT"
inherit perl-module

DESCRIPTION="Generate SQL from Perl data structures"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="test"

RDEPEND="dev-perl/Test-Deep"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Exception
		dev-perl/Test-Warn )"

SRC_TEST="do"
