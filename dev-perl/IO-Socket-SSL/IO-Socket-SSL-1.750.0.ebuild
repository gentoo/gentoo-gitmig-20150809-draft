# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-SSL/IO-Socket-SSL-1.750.0.ebuild,v 1.1 2012/06/16 20:16:51 tove Exp $

EAPI=4

MODULE_AUTHOR=SULLR
MODULE_VERSION=1.75
inherit perl-module

DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="idn"

DEPEND="
	>=dev-perl/Net-SSLeay-1.330.0
	virtual/perl-Scalar-List-Utils
	>=virtual/perl-Socket-1.950.0
	idn? (
		|| (
			>=dev-perl/URI-1.50
			dev-perl/Net-LibIDN
		)
	)"
RDEPEND="${DEPEND}"

SRC_TEST="do"
