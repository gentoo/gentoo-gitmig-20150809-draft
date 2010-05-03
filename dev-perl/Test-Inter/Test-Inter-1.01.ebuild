# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Inter/Test-Inter-1.01.ebuild,v 1.3 2010/05/03 07:26:47 tove Exp $

EAPI="3"

MODULE_AUTHOR="SBECK"
inherit perl-module

DESCRIPTION="Framework for more readable interactive test scripts"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod-Coverage
		dev-perl/Test-Pod )"

SRC_TEST="do"
