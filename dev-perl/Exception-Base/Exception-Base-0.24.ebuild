# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Base/Exception-Base-0.24.ebuild,v 1.1 2009/12/14 18:24:24 tove Exp $

EAPI=2

MODULE_AUTHOR="DEXTER"
inherit perl-module

DESCRIPTION="Error handling with exception class"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( >=dev-perl/Test-Unit-Lite-0.12 )"

SRC_TEST=do
