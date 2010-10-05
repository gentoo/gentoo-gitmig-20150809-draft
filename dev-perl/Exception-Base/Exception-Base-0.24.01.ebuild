# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Base/Exception-Base-0.24.01.ebuild,v 1.1 2010/10/05 16:39:47 tove Exp $

EAPI=2

inherit versionator
MY_P=${PN}-$(delete_version_separator 2 )
S=${WORKDIR}/${MY_P}
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
