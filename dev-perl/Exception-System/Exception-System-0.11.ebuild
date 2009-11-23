# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-System/Exception-System-0.11.ebuild,v 1.3 2009/11/23 20:48:50 tove Exp $

EAPI=2

MODULE_AUTHOR="DEXTER"
inherit perl-module

DESCRIPTION="Exception class for system or library calls"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Exception-Base-0.22.01"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( >=dev-perl/Test-Unit-Lite-0.12 )"

SRC_TEST=do
