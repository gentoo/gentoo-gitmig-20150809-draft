# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Assert/Test-Assert-0.0504.ebuild,v 1.1 2009/12/10 07:45:47 tove Exp $

EAPI=2

MODULE_AUTHOR="DEXTER"
inherit perl-module

DESCRIPTION="Assertion methods for those who like JUnit."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/constant-boolean
	>=dev-perl/Exception-Base-0.22.01
	dev-perl/Symbol-Util"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	dev-perl/Class-Inspector
	virtual/perl-parent
	>=dev-perl/Test-Unit-Lite-0.12"

SRC_TEST=do
