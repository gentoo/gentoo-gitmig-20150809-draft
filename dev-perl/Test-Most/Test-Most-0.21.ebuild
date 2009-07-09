# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Most/Test-Most-0.21.ebuild,v 1.2 2009/07/09 16:20:16 tove Exp $

EAPI=2

MODULE_AUTHOR=OVID
inherit perl-module

DESCRIPTION="Most commonly needed test functions and features"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Exception-Class
	dev-perl/Test-Warn
	dev-perl/Test-Deep
	dev-perl/Test-Differences
	dev-perl/Test-Exception
	>=virtual/perl-Test-Simple-0.82"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
