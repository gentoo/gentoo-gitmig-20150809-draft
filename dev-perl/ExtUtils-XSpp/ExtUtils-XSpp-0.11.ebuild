# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-XSpp/ExtUtils-XSpp-0.11.ebuild,v 1.2 2010/06/15 05:38:52 tove Exp $

EAPI=2

MODULE_AUTHOR=MBARBON
inherit perl-module

DESCRIPTION="XS for C++"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/Test-Differences
		dev-perl/Test-Base )"
RDEPEND=">=virtual/perl-ExtUtils-ParseXS-2.22.02"

SRC_TEST=do
