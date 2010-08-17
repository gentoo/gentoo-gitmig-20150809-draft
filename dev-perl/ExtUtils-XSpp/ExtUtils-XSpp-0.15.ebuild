# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-XSpp/ExtUtils-XSpp-0.15.ebuild,v 1.1 2010/08/17 08:30:39 tove Exp $

EAPI=3

MODULE_AUTHOR=SMUELLER
MODULE_AUTHOR=MBARBON
inherit perl-module

DESCRIPTION="XS for C++"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/Test-Differences
		dev-perl/Test-Base )"
RDEPEND=">=virtual/perl-ExtUtils-ParseXS-2.22.02"

SRC_TEST=do
