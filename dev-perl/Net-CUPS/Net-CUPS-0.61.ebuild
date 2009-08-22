# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-CUPS/Net-CUPS-0.61.ebuild,v 1.1 2009/08/22 22:36:25 tove Exp $

EAPI=2

MODULE_AUTHOR=DHAGEMAN
inherit perl-module

DESCRIPTION="CUPS C API Interface"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="test"

RDEPEND=">=net-print/cups-1.1.21"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
