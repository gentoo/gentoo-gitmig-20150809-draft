# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Perl-OSType/Perl-OSType-1.2.ebuild,v 1.1 2011/01/29 09:40:31 tove Exp $

EAPI=3

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=1.002
inherit perl-module

DESCRIPTION="Map Perl operating system names to generic types"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		>=virtual/perl-Test-Simple-0.88
	)"

SRC_TEST="do"
