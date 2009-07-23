# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/UltraDNS/UltraDNS-0.06.ebuild,v 1.1 2009/07/23 01:31:17 robbat2 Exp $

MODULE_AUTHOR="TIMB"

inherit perl-module

DESCRIPTION="Client API for the NeuStar UltraDNS Transaction Protocol"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/Net-SSLeay-1.35
	dev-perl/Test-Exception
	dev-perl/RPC-XML
	dev-perl/XML-LibXML
	dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"

mydoc="NUS_API_XML.errata"
