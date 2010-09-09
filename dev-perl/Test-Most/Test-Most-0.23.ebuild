# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Most/Test-Most-0.23.ebuild,v 1.1 2010/09/09 05:23:56 tove Exp $

EAPI=3

MODULE_AUTHOR=OVID
inherit perl-module

DESCRIPTION="Most commonly needed test functions and features"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/Exception-Class-1.14
	>=dev-perl/Test-Warn-0.11
	>=dev-perl/Test-Deep-0.106
	>=dev-perl/Test-Differences-0.50.0
	>=dev-perl/Test-Exception-0.29
	>=virtual/perl-Test-Harness-3.07
	>=virtual/perl-Test-Simple-0.88"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
