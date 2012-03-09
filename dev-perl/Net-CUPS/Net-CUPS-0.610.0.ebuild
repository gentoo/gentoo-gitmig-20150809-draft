# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-CUPS/Net-CUPS-0.610.0.ebuild,v 1.3 2012/03/09 09:01:16 phajdan.jr Exp $

EAPI=4

MODULE_AUTHOR=DHAGEMAN
MODULE_VERSION=0.61
inherit perl-module

DESCRIPTION="CUPS C API Interface"

SLOT="0"
KEYWORDS="amd64 ~ia64 x86"
IUSE="test"

RDEPEND=">=net-print/cups-1.1.21"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
