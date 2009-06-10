# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-CompactTree-XS/XML-CompactTree-XS-0.02.ebuild,v 1.2 2009/06/10 01:43:42 robbat2 Exp $

MODULE_AUTHOR="PAJAS"

inherit perl-module

DESCRIPTION="a fast builder of compact tree structures from XML documents"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/XML-LibXML-1.69"
RDEPEND="${DEPEND}"

SRC_TEST="do"
