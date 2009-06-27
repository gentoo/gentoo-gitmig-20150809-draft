# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-BOM/File-BOM-0.14.ebuild,v 1.1 2009/06/27 07:19:53 tove Exp $

EAPI=2

MODULE_AUTHOR=MATTLAW
inherit perl-module

DESCRIPTION="Utilities for handling Byte Order Marks"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Readonly"
DEPEND="virtual/perl-Module-Build
	test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Test-Exception )"

SRC_TEST=do
