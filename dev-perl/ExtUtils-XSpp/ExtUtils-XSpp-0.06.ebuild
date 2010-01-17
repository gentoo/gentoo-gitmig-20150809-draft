# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-XSpp/ExtUtils-XSpp-0.06.ebuild,v 1.1 2010/01/17 10:35:03 tove Exp $

EAPI=2

MODULE_AUTHOR=MBARBON
inherit perl-module

DESCRIPTION="XS for C++"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/Test-Differences
		dev-perl/Test-Base )"
RDEPEND=">=virtual/perl-ExtUtils-ParseXS-2.22"

SRC_TEST=do
